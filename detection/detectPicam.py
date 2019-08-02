import websocket
import numpy as np
from  detecter import Detecter
import cv2
import requests
import datetime
import time
import json
from threading import Thread, Lock

SERVER_IP = '70.12.109.136'
DROID_CAM_URL = 'http://70.12.240.197:4747/video'
WEB_SOCKET_URL = 'ws://'+SERVER_IP+'/autocar/car'
WEB_VIDEO_URL = 'http://'+SERVER_IP+'/autocar/camera/1'
VIOLATE_URL = 'http://'+SERVER_IP+'/autocar/violate'

cap = cv2.VideoCapture(DROID_CAM_URL)
THRESHOLD = 0.3
detecter = Detecter()
detecter.setup('./frozen_inference_graph.pb', './object-detection.pbtxt')

data = {
    "msgType":"DETECTION", # 메세지 종류
    "target":1, 
    "stop":0,
    "truck":0,
    "noparking":0,
    "bus":0,
    "green":0,
    "left":0,
    "red":0, 
    "yellow":0
}

counter = {
    "stop":0,
    "truck":0,
    "noparking":0,
    "bus":0,
    "green":0,
    "left":0,
    "red":0, 
    "yellow":0
}

def on_message(ws, message):
    print('on_message')

def on_error(ws, error):
    print(error)

def on_close(ws):
    print("### closed ###")

def on_open(ws):
    def run(*args):
        while(True):
            time.sleep(0.5)
            
            # 상태 데이터 1초마다 전송
            global data
            
            # 불법주차 발견시 저장~
            #if data["noparking"] >= 1 and data["truck"] >= 1 : 
            if data["truck"] >= 1 : 
                print('와 걸렸다.')
                requests.post(VIOLATE_URL)

            sendingmsg = json.dumps(data)
            ws.send(sendingmsg)
            
        time.sleep(1)
        ws.close()
        print("thread terminating...")
    
    Thread(target=run).start()

ws = websocket.WebSocketApp(WEB_SOCKET_URL,
    on_open = on_open,
    on_close = on_close,
    on_message = on_message,
    on_error = on_error)

Thread(target=ws.run_forever).start()

cnt = 0

while(True):
    # Capture frame-by-frame
    ret, frame = cap.read()

    image = frame
    image.setflags(write=1)
    image_ex = np.expand_dims(image, axis=0)
    
    (boxes, scores, classes, num) = detecter.detect(image_ex)
    
    (boxes, scores, classes) = (np.squeeze(boxes), np.squeeze(scores), np.squeeze(classes).astype(np.uint8))
    detecter.visualize(image, boxes, classes, scores, THRESHOLD)

    jpgImage = cv2.imencode('.jpg', image)[1].tostring()
    file = {'image' : jpgImage}

    # 웹으로 이미지 전송
    requests.post(WEB_VIDEO_URL, files = file)
    
    #cv2.imshow('Object detector', image)
    
    obj = detecter.get_found()
    
    for str in obj:
        arr = str.split('/')
        class_name = arr[0]
        counter[class_name] += 1
        
    cnt += 1

    if cnt == 10:
        cnt = 0
        print(counter)
        
        data["stop"] = counter["stop"] // 5 
        data["truck"]= counter["truck"] // 5 
        data["noparking"]= counter["noparking"] // 5 
        data["bus"]= counter["bus"] // 5 
        data["green"]= counter["green"] // 5 
        data["left"]= counter["left"] // 5 
        data["red"]= counter["red"] // 5 
        data["yellow"]= counter["yellow"] // 5 

        counter = dict.fromkeys(['stop','truck','noparking','bus','green','left','red','yellow'],0)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()