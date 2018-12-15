function [ result ] = Inverse_Quantize_Dct( I,Quantize_Table ,Quality_Factor)

Qua_Matrix=Quality_Factor.*Quantize_Table;     %����������
I=blkproc(I,[8 8],'x.*P1',Qua_Matrix);%����������������
 
[row,column]=size(I);
 
I=blkproc(I,[8 8],'IDCT_Transform(X)');   %T���任
 
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
 
result=I;       %�������ͷ�Dct��ľ���
end