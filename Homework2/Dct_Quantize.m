function [Matrix]=Dct_Quantize(I,Qua_Factor,Qua_Table)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
I=double(I)-128; 
I=blkproc(I,[8 8],'DCT_Transform(x)');
 
Qua_Matrix=Qua_Factor.*Qua_Table;              %��������������ϵ����������õ�
I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %��������������
 
Matrix=I;          %�õ�������ľ���
end