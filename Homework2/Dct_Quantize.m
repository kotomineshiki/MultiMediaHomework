function [result]=DCT_Quantize(I,Quantize_Table,Quality_Factor)

I=double(I)-128; 
I=blkproc(I,[8 8],'DCT_Transform(x)');
 
Qua_Matrix=Quality_Factor.*Quantize_Table;              %��������������ϵ����������õ�
I=blkproc(I,[8 8],'round(x./P1)',Qua_Matrix);  %��������������
 
result=I;          %�õ�������ľ���
end