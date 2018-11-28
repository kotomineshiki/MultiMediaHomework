function [ Matrix ,listedblock] =Run_Length_Encoding( I )%化矩阵为一维数组，再将其转换成游长编码的二维数组
    [row,col]=size(I);%得到矩阵的大小 
    Z_Scan_Table=[%z型扫描的转化表，由C++工具得到
        1 2 6 7 15 16 28 29 
        3 5 8 14 17 27 30 43 
        4 9 13 18 26 31 42 44 
        10 12 19 25 32 41 45 54 
        11 20 24 33 40 46 53 55 
        21 23 34 39 47 52 56 61 
        22 35 38 48 51 57 60 62 
        36 37 49 50 58 59 63 64];
    
    result=zeros(0,4);
    for m=1:floor(row/8)
        for n=1:floor(col/8)%分块处理
            listedblock=zeros(1,64);%生成一个一维数组

            for i=(m-1)*8+1:(m-1)*8+8
               for j=(n-1)*8+1:(n-1)*8+8

                   position=Z_Scan_Table(i-(m-1)*8,j-(n-1)*8);%得到应该有的位置

                    listedblock(1,position)=I(i,j);%把数据放置到对应的位置上
                  
               end
            end
            zero_count=0;%前面的0的个数
            %数组转化成二维数组
            for i=2:64%从二开始时为了防止第一位是0的情况

                if(listedblock(1,i)==0)
                    zero_count=zero_count+1;
                else
                    %加入二维数组
                    
                    result(end+1,:)=[zero_count, listedblock(1,i),m,n];
                    zero_count=0;
                end
            end
            if(zero_count~=0)%结尾处为0
                result(end+1,:)=[0, 0,m,n];%则加入【0，0】
            end
        end
    end
    Matrix=result;%返回二维数组
end