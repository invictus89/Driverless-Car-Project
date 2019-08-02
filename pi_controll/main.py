# -*- coding: utf-8 -*-  # 한글 주석쓰려면 이거 해야함
#from pi_cam import PiCam
from controll import CarControl
from threading import Thread

if __name__ == "__main__":
    
    threads = []
    
    # Send Image to server
    #image_sender = Thread(target=PiCam('http://70.12.109.136/autocar/camera/1',frame).cam_send)
    #threads.append(image_sender)
    #image_sender.start()
    
    # Controller
    car_controller = Thread(target=CarControl('ws://70.12.109.136/autocar/car').ws.run_forever)
    threads.append(car_controller)
    car_controller.start()
    
    for thread in threads:
        thread.join()
    