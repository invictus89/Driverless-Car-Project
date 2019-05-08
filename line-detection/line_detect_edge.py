# -*- coding: utf-8 -*-  # 한글 주석쓰려면 이거 해야함
import cv2 # opencv 사용
import numpy as np
import matplotlib.pyplot as plt

#흑백이미지로 변환
def grayscale(img):
    return cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

def canny(img, low_threshold, high_threshold):
    return cv2.Canny(img, low_threshold, high_threshold)

#가우시안 필터링을 통해 영상을 부드럽게 한다.
#이미지의 잡음을 없앤다.
#kernel_size를 키움으로써 잡음 제거 효과를 높일 수 있다.(단, 짝수는 안된다)
def gaussian_blur(img, kernel_size):
    return cv2.GaussianBlur(img, (kernel_size, kernel_size), 0)

#관심 영역 설정하기
def set_of_roi(img, vertices, color3=(255, 255, 255), color1 = 255):
    mask = np.zeros_like(img)
    
    #3채널일때
    if len(img.shape) > 2:
        color = color3
    else: #흑백일때
        color = color1    

    cv2.fillPoly(mask, vertices, color) #빈 흑백이미지에 관심영역 컬러 표시
    roi_img = cv2.bitwise_and(img, mask) # 본 이미지에서 관심영역 밖은 검은색, 안은 위의 설정된 값으로

    return roi_img

def draw_lines(img, lines, color=[0, 0, 255], thickness=2):
    print(len(lines))
    for line in lines:
        for x1, y1, x2, y2 in line:
            cv2.line(img, (x1, y1), (x2, y2), color, thickness)

#img : 가우시안 필터를 통한 직선 검출 및 gray scale 된 이미지
#rho : p 값을 얼마나 증가시키며 조사할 것인지(보통 1)
#theta : 라디안, 각도를 얼마나 증가시키며 조사할 것인지 (보통 1라디안)
#threshold : 교차점이 생길 때마다 1씩 증가, 이 값이 높아지면 적지만 확실한 직선 검출
#min_line_len: 최소 선의 길이
#max_line_gap : 선위의 점들의 최대 길이
def hough_lines(img, rho, theta, threshold, min_line_len, max_line_gap):
    lines = cv2.HoughLinesP(img, rho, theta, threshold, np.array([]), minLineLength=min_line_len, maxLineGap=max_line_gap)
    #lines : 선분들의 시작점과 끝점에 대한 좌표
    line_img = np.zeros((img.shape[0], img.shape[1], 3), dtype=np.uint8)
    draw_lines(line_img, lines)

    return line_img

# 두 이미지 operlap 하기
def weighted_img(img, initial_img, α=1, β=1., λ=0.): 
    return cv2.addWeighted(initial_img, α, img, β, λ)


#이미지
image = cv2.imread('test1.jpg')
height, width = image.shape[:2]

gray_img = grayscale(image)
blur_img = gaussian_blur(gray_img, 3)
canny_img = canny(blur_img, 70, 210)

vertices = np.array([[(-300,height),(width/2-100, height/2-70), (width/2+100, height/2-70), (width+300,height)]], dtype=np.int32)

ROI_img = set_of_roi(canny_img, vertices) # ROI 설정
#ROI_img = set_of_roi(image, vertices) # ROI 설정

hough_img = hough_lines(ROI_img, 1, 1 * np.pi/180, 30, 10, 20) # 허프 변환
result = weighted_img(hough_img, image) # 원본 이미지에 검출된 선 overlap
#cv2.imshow('result',result) # 결과 이미지 출력
cv2.imshow("roi_img", hough_img)
cv2.waitKey(0) 


'''
#영상
cap = cv2.VideoCapture('video2.mp4') # 동영상 불러오기

while(cap.isOpened()):
    ret, image = cap.read()

    height, width = image.shape[:2] # 이미지 높이, 너비
    gray_img = grayscale(image) # 흑백이미지로 변환
    blur_img = gaussian_blur(gray_img, 3) # Blur 효과
    canny_img = canny(blur_img, 70, 210) # Canny edge 알고리즘

    #vertices = np.array([[(50,height),(width/2-45, height/2+60), (width/2+45, height/2+60), (width-50,height)]], dtype=np.int32)
    vertices = np.array([[(-200,height),(width/2-60, height/2-130), (width/2+60, height/2-130), (width+200,height)]], dtype=np.int32)

    ROI_img = set_of_roi(canny_img, vertices) # ROI 설정

    hough_img = hough_lines(ROI_img, 1, 1 * np.pi/180, 25, 10, 20) # 허프 변환

    result = weighted_img(hough_img, image) # 원본 이미지에 검출된 선 overlap
    cv2.imshow('result',result) # 결과 이미지 출력
    cv2.imshow('hough', hough_img)

    if cv2.waitKey(100) & 0xFF == ord('q'):
        break

# Release
cap.release()
cv2.destroyAllWindows()
'''