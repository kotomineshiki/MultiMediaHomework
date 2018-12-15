function [result]=DCT_Quantize(I,Quantize_Table,Quality_Factor)

I=double(I)-128; 
I=blkproc(I,[8 8],'DCT_Transform(x)');
 
Qua_Matrix=Quality_Factor.*Quantize_Table;              %量化矩阵由量化系数乘量化表得到
I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %量化，四舍五入
 
result=I;          %得到量化后的矩阵
end