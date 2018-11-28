function [Matrix]=Dct_Quantize(I,Qua_Factor,Qua_Table)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I=double(I)-128; 
I=blkproc(I,[8 8],'DCT_Transform(x)');
 
Qua_Matrix=Qua_Factor.*Qua_Table;              %量化矩阵由量化系数乘量化表得到
I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %量化，四舍五入
 
Matrix=I;          %得到量化后的矩阵
end