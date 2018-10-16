import cv2
import copy
def changeColor(block,color,img):#改变块内所有的颜色为color，并写入img中
    for i in block:
       # print(i)
       # print(i[0])
        img[i[4],i[3]]=color[0:3]

def calculateColor(block):#传入块，返回颜色
    sum=[0,0,0]
    for i in block:
        sum[0]+=i[0]
        sum[1]+=i[1]
        sum[2]+=i[2]
    sum[0]=sum[0]/len(block)
    sum[1]=sum[1]/len(block)
    sum[2]=sum[2]/len(block)
    return sum
def recursive_median_cut(block,bit, value, depth, colorset,img):#数据 当前编码 上一层给该组的编码，深度
    if depth == 9:
        bit.append(value)
        print(bit)#打印当前编码
        color=calculateColor(block)
        print(color)
        colorset.append(color)#添加进入颜色集
        changeColor(block,color,img)
     #   print("Hello")
        return#保存并结束
    else:
        bit.append(value)#在当前编码中写入上一层给该组的编码
        block.sort(key=lambda x:x[depth%3])#给块排序
        median=len(block)//2# 找到块的中值的个数
        leftblock=block[:median-1]
        recursive_median_cut(leftblock,copy.deepcopy(bit),0,depth+1,colorset,img)#左遍历
        rightblock=block[median+1-1:]
        recursive_median_cut(rightblock,copy.deepcopy(bit),1,depth+1,colorset,img)#右遍历

img = cv2.imread("F:\imagePrograming\\redapple.jpg")
cv2.namedWindow("redApple")
cv2.imshow("redApple", img)
rows,cols,dims=img.shape
first_pass =[]
for i in range(0,725):
    for j in range(0,409):
        first_pass.append(img[j,i].tolist()+[i,j])#向第一次排序的数组中添加像素点
colorset=[]
recursive_median_cut(first_pass,[],0,1,colorset,img)
#print("YEs")
#print(colorset)
#替换颜色


final_img=img
cv2.namedWindow("final")
cv2.imshow("final",final_img)#显示处理过的图像
cv2.waitKey(0)
cv2.destroyWindow("redApple")
#传入块 和 上一层次赋予的值
#if depth==8  计算结果保存并输出
# else{ 先序遍历 进行下一层递归
# 先给块内所有的颜色附上位值
#求中值
#左子树（小块和0,depth++）
#右子树（大块和1,depth++）
#



