function [ result ] = Inverse_Quantize_Dct( I,Quantize_Table ,Quality_Factor)

Qua_Matrix=Quality_Factor.*Quantize_Table;     %反量化矩阵
I=blkproc(I,[8 8],'x.*P1',Qua_Matrix);%反量化，四舍五入
 
[row,column]=size(I);
 
I=blkproc(I,[8 8],'IDCT_Transform(X)');   %T反变换
 
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
 
result=I;       %反量化和反Dct后的矩阵
end