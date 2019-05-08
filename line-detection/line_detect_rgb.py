# -*- coding: utf-8 -*-  # 한글 주석쓰려면 이거 해야함
import cv2 # opencv 사용
import numpy as np
import matplotlib as plt

#관심 영역 설정
#이미지 처리의 연산량을 줄이기 위해 관심 영역 설정 필요
def set_of_roi(img, vertices, color3=(0, 0, 255), color1 = 255):
    mask = np.zeros_like(img)
    
    if len(img.shape) > 2:
        color = color3
    else:
        color = color1    
    cv2.fillPoly(mask, vertices, color)
    roi_img = cv2.bitwise_and(img, mask)

    return roi_img

def mark_img(img, blue_threshold=100, green_threshold=100, red_threshold=100):
    bgr_threshold = [blue_threshold, green_threshold, red_threshold]

    # 제한 RGB 값보다 작으면 검은색으로 인식
    thresholds = (image[:,:,0] < bgr_threshold[0]) \
                | (image[:,:,1] < bgr_threshold[1]) \
                | (image[:,:,2] < bgr_threshold[2])

    mark[thresholds] = [0,0,0]

    return mark

'''
image = cv2.imread('test2.jpg') # 이미지 읽기
height, width = image.shape[:2] # 이미지 높이, 너비
print('height:', height)
print('width:', width)
# 사다리꼴 모형의 Points
vertices = np.array([[(-1100,height),(width/2-100, height/2-350), (width/2+100, height/2-350), (width+1100,height)]], dtype=np.int32)
roi_img = set_of_roi(image, vertices) # vertices에 정한 점들 기준으로 ROI 이미지 생성

mark = np.copy(roi_img) # roi_img 복사
mark = mark_img(roi_img) # 흰색 차선 찾기

color_thresholds = (mark[:,:,0] == 0) & (mark[:,:,1] == 0) & (mark[:,:,2] > 200)
#print(mark[:,:,2])
#print(color_thresholds)
image[color_thresholds] = [0,0,255]
#print(image[color_thresholds])

cv2.imshow('original',image) # 이미지 출력
cv2.imshow("roi", roi_img)
cv2.imshow('result',mark) # 흰색 추출 이미지 출력

cv2.waitKey(0) 

'''

#solidWhiteCurve.jpg
#sangwoo.h264

cap = cv2.VideoCapture('testVideos.mp4') # 동영상 불러오기

while(cap.isOpened()):
    ret, image = cap.read()
    #image = cv2.flip(image,0)
    height, width = image.shape[:2] # 이미지 높이, 너비
    vertices = np.array([[(50,height),(width/2-50, height/2-50), (width/2+50, height/2-50), (width-50, height)]], dtype=np.int32)
    #vertices = np.array([[(-850,height),(width/2-100, height/2-200), (width/2+100, height/2-200), (width+850,height)]], dtype=np.int32)
    #vertices = np.array([[(-1100,height),(width/2-100, height/2-350), (width/2+100, height/2-350), (width+1100,height)]], dtype=np.int32)

    roi_img = set_of_roi(image, vertices, [0, 0, 255]) # vertices에 정한 점들 기준으로 ROI 이미지 생성
    
    mark = np.copy(roi_img) # roi_img 복사
    mark = mark_img(roi_img) # 흰색 차선 찾기

    # 흰색 차선 검출한 부분을 원본 image에 overlap 하기
    color_thresholds = (mark[:,:,0] == 0) & (mark[:,:,1] == 0) & (mark[:,:,2] > 100)
    image[color_thresholds] = [0,0,255]

    cv2.imshow('roi_img',roi_img) # 이미지 출력
    cv2.imshow('mark',mark) # 이미지 출력
    cv2.imshow('image',image) # 이미지 출력
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release
cap.release()
cv2.destroyAllWindows()
