function [ Matrix ] =DPCM_Encoding( I )%把块变成数组，每个元素可以得知与上个数的平均数的差值
    [row,col]=size(I);%得到矩阵的大小 
    result=zeros(0,1);
    DPCMbase=0;
    DPCMcurrent=0;
    for m=1:floor(row/8)
        for n=1:floor(col/8)%分块处理
            if(m==1&&n==1)
                DPCMbase=I(1,1);%得到基准线
                disp(I(1,1));
                result(end+1)=DPCMbase;
                continue;
            end
            DPCMcurrent=I((m-1)*8+1,(n-1)*8+1);
            result(end+1)=DPCMcurrent-DPCMbase;%存入数组
            DPCMbase=DPCMcurrent;
            
           
        end
    end
    Matrix=result;%返回数组

end