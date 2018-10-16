import cv2


def isinarea(x, y, rad):
    if (x-203.5)**2+(y-203.5)**2 < rad**2:
        return 1
    else:
        return 0


img_lena = cv2.imread("F:\imagePrograming\lena.jpg")
img_nobel = cv2.imread("F:\imagePrograming\\nobel.jpg")

cv2.namedWindow("lena")
cv2.namedWindow("nobel")
cv2.imshow("lena", img_lena)
cv2.imshow("nobel", img_nobel)
cv2.namedWindow("mixed")
img_mixed = img_nobel
radius = 1
while radius < 288:
    radius = radius+5
    for i in range(0, 407):
        for j in range(0, 407):
            if(isinarea(i, j, radius) == 1):
                img_mixed[i, j] = img_lena[i, j]
            else:
                pass

    cv2.imshow("mixed", img_mixed)
    cv2.waitKey(0)

cv2.destroyAllWindows()


