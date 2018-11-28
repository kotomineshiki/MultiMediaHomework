function [ Matrix ] = Inverse_Quantize_Dct( I,Qua_Factor,Qua_Table )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 
Qua_Matrix=Qua_Factor.*Qua_Table;     %����������
I=blkproc(I,[8 8],'x.*P1',Qua_Matrix);%����������������
 
[row,column]=size(I);
 
I=blkproc(I,[8 8],'idct2(x)');   %T���任
 
I=uint8(I+128);
for i=1:row
    for j=1:column
        if I(i,j)>255
            I(i,j)=255;
        elseif I(i,j)<0
            I(i,j)=0;
        end
    end
end
 
Matrix=I;       %�������ͷ�Dct��ľ���
end