import cv2
import numpy as np
import math
import time

def region_of_interest(img, vertices, color3=(255, 255, 255), color1 = 255): # ROI
    mask = np.zeros_like(img) # mask empty image
    
    if len(img.shape) > 2: # Color image is three channel
        color = color3
    else: #gray
        color = color1
    
    cv2.fillPoly(mask, vertices, color)
    
    ROI_image = cv2.bitwise_and(img, mask)
    return ROI_image
    
def mark_img(img, blue_threshold = 200, green_threshold = 200, red_threshold = 200):
    bgr_threshold = [blue_threshold, green_threshold, red_threshold]
    thresholds = (img[:,:,0] < bgr_threshold[0])\
                 | (img[:,:,1] < bgr_threshold[1])\
                 | (img[:,:,2] < bgr_threshold[2])
    mark = np.copy(img)
    mark[thresholds] = [0, 0, 0]
    return mark

def calc_angle(image):
    
    if image is None:
        print('No Image')
        return 360

    start_time = time.time()

    height, width = image.shape[:2]

    vertices = np.array([[(0, height - 1), (0, height//2 - 1), (width - 1, height//2 - 1), (width - 1, height - 1)]], dtype = np.int32)

    roi_img = region_of_interest(image, vertices)

    mark = np.copy(roi_img)
    mark = mark_img(roi_img)

    #standard = (width//2, height//2)
    #standard = (width//2, height//3 * 2)
    standard = (width//2, height//4 * 3)
    bot_center = (width//2, height)
    drawing_image = image.copy()
    cv2.circle(drawing_image, standard, 5, (0, 0, 255), 2)
    cv2.circle(drawing_image, bot_center, 5, (0, 255, 0), 2)

    left_col = standard[0]
    right_col = standard[0]
    overLine_check = standard[1]

    gray = cv2.cvtColor(mark, cv2.COLOR_BGR2GRAY)
        
    
    while (overLine_check < height - 1):
        if gray[overLine_check][standard[0]] != 0:
            return 1000
        overLine_check = overLine_check + 1
            
    while (left_col > 0):
        left_col = left_col - 1
        if gray[standard[1]][left_col] != 0:
            break

    while right_col < width - 1:
        right_col = right_col + 1
        if gray[standard[1]][right_col] != 0:
            break
               
    next_point = ((left_col + right_col)//2, standard[1])
    cv2.circle(drawing_image, next_point, 5, (255, 0, 0), 2)
    theta = math.atan2((next_point[0] - standard[0]), (bot_center[1] - standard[1])) * 180/3.141592
    
    cv2.line(drawing_image, bot_center, next_point, (0, 0, 0), 1)
    cv2.imshow('roi_white', mark) # white image
    # cv2.imshow('gray', gray)
    cv2.imshow('drawing_image', drawing_image)
    # cv2.imshow('result', image) # original image
    cv2.waitKey(1)
    # cv2.destroyAllWindows()
    
    return theta