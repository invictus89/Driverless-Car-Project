import websocket
from threading import Thread, Lock
import time
import json
import math

from picamera.array import PiRGBArray
from picamera import PiCamera
import cv2
import autocar_detect_line_module2 as adlm
from bluetooth import *

class CarControl(Thread):
    
    def __init__(self, url):
        self.direction = "STOP" # 현재 진행 방향 
        self.isConnected = 1 # 파이 접속 상태
        self.url = url
        self.status = {
            "msgType":"STATUS", # 메세지 종류
            "target":1,         # 대상
            "connected": 1,     # 연결 상태 ( 0 : false , 1 : true)
            "direction": "STOP" # 방향 (LEFT, RIGHT, FORWARD, BACK, STOP)
        }
        self.log = {
            "msgType":"LOG", # 메세지 종류
            "target":1,      # 대상
            "content": ""    # 메시지
        }
        
        self.ws = websocket.WebSocketApp(self.url,
                                on_open = lambda ws : self.on_open(ws),
                                on_close = lambda ws : self.on_close(ws),
                                on_message = lambda ws,message : self.on_message(ws,message),
                                on_error = lambda ws,message :  self.on_error(ws,message))
        
        
        self.client_socket = BluetoothSocket(RFCOMM)
        self.client_socket.connect(("98:D3:71:F9:73:2F",1))

        self.width = 640
        self.height = 480

        self.camera = PiCamera()
        self.camera.resolution = (self.width, self.height)
        self.camera.rotation = 180
        self.camera.framerate = 32
        self.fps = 0
        
        # camera.hflip = True
        self.rawCapture = PiRGBArray(self.camera, size = (self.width, self.height))

        # ready picamera
        time.sleep(2)        
        self.start_time = time.time()
        self.do_run = False
        
        
        self.lane_keeper = None
    
    
    def lane_keep(self, *args):
        
        for image in self.camera.capture_continuous(self.rawCapture, format="bgr", use_video_port=True):
            
            frame = image.array
            theta = adlm.calc_angle(frame)
                        
            direct = 0   # 1 : forward , 2 : back, 3 : left, 4: right, 5 : stop1 6 : overline
            
            if (theta >= -6 and theta <= 6) :
                direct = 1
            elif (theta < -6) :
                direct = 3
            elif (theta == 1000) :
                direct = 6
            elif (theta > 6) :
                direct = 4
            
            self.logger(self.ws,"[AUTO] "+str(direct)+' '+str(theta))
            
            print(str(direct)+' '+str(theta))
            
            self.client_socket.send(str(direct))

            self.rawCapture.truncate(0)
            key = cv2.waitKey(1) & 0xFF
            if key == ord("q"):
                print('Quit')
                break
            self.fps = self.fps + 1
            
            if not self.do_run:
                break
        print('close')            
    
    def on_message(self, ws, message):
        
        loaddic=json.loads(message)
        
        if(loaddic["msgType"]=="CONTROL"):
            
            if(loaddic["isAutoMode"]== 1): # 자율주행 모드
                print("[CONTROL] AUTONOMOUS MODE")
                self.logger(ws, "[CONTROL] AUTONOMOUS MODE")
                
                if self.lane_keeper == None or not self.lane_keeper.is_alive():
                    print('is not alive')
                    
                    self.lane_keeper = Thread(target=self.lane_keep)
                    self.do_run = True
                    self.lane_keeper.start()
            
            else:
                self.do_run = False
                cv2.destroyAllWindows()
                
                # 1 : forward , 2 : back, 7 : left, 8: right, 5 : stop1 6 : overline
                if(loaddic["direction"]=="LEFT"):
                    self.direction = "LEFT"
                    self.client_socket.send('7')
                elif(loaddic["direction"]=="RIGHT"):
                    self.direction = "RIGHT"
                    self.client_socket.send('8')
                elif(loaddic["direction"]=="BACK"):
                    self.direction = "BACK"
                    self.client_socket.send('2')
                elif(loaddic["direction"]=="FORWARD"):
                    self.direction = "FORWARD"
                    self.client_socket.send('1')
                elif(loaddic["direction"]=="STOP"):
                    self.direction = "STOP"
                    self.client_socket.send('5')
                # log 전송
                print("[CONTROL] "+self.direction)
                self.logger(ws,"[CONTROL] "+self.direction)
    
            # ...
            

    def on_error(self, ws, error):
        print(error)

    def on_close(self, ws):
        print("### closed ###")

    def on_open(self, ws):
        def init():
            initdic={
                "msgType" : "CONTROL_SUB",
                "target" : 1
            }
            initmessage = json.dumps(initdic)
            ws.send(initmessage)
            print('websocket is conncted.')
            print('add to control')
            
            
        def run(*args):
            while(True):
                time.sleep(1)
                
                # 상태 데이터 1초마다 전송
                self.status["direction"] = self.direction
                self.status["connected"] = self.isConnected
                
                sendingmsg = json.dumps(self.status)
                ws.send(sendingmsg)
                
            time.sleep(1)
            ws.close()
            print("thread terminating...")

        init()
        Thread(target=run).start()

    def logger(self, ws, content):
        self.log["content"] = content
        sendingmsg = json.dumps(self.log)
        ws.send(sendingmsg)