function [ Matrix ] =DPCM_Encoding( I )%�ѿ������飬ÿ��Ԫ�ؿ��Ե�֪���ϸ�����ƽ�����Ĳ�ֵ
    [row,col]=size(I);%�õ�����Ĵ�С 
    result=zeros(0,1);
    DPCMbase=0;
    DPCMcurrent=0;
    for m=1:floor(row/8)
        for n=1:floor(col/8)%�ֿ鴦��
            if(m==1&&n==1)
                DPCMbase=I(1,1);%�õ���׼��
                disp(I(1,1));
                result(end+1)=DPCMbase;
                continue;
            end
            DPCMcurrent=I((m-1)*8+1,(n-1)*8+1);
            result(end+1)=DPCMcurrent-DPCMbase;%��������
            DPCMbase=DPCMcurrent;
            
           
        end
    end
    Matrix=result;%��������

end