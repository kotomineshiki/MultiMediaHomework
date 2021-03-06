function [ Matrix ,J,K] =DPCM_RLE_Decoding( RLE,DCPM , Matrix_size)%把得到的游长编码和DPCM编码整合，恢复到之前的状态.size 是原图的大小
    Z_Scan_Table=[%z型扫描的转化表，由C++工具得到
        1 2 6 7 15 16 28 29 
        3 5 8 14 17 27 30 43 
        4 9 13 18 26 31 42 44 
        10 12 19 25 32 41 45 54 
        11 20 24 33 40 46 53 55 
        21 23 34 39 47 52 56 61 
        22 35 38 48 51 57 60 62 
        36 37 49 50 58 59 63 64];
   
Z_Scan_Table_Inversed=zeros(3,64);%得到逆变换表
 for i=1:64
     Z_Scan_Table_Inversed(1,i)=i;
     [x,y]=find(Z_Scan_Table==i);
     Z_Scan_Table_Inversed(2:3,i)=[x,y];

 end




    result=zeros(Matrix_size);
    row=Matrix_size(1);
    col=Matrix_size(2);
    DCPM_recover=DCPM;
    [~,DCPMLength]=size(DCPM_recover);
    for k=1:DCPMLength%遍历DCPM
        if(k==1)
            continue;
        end
        DCPM_recover(k)=DCPM_recover(k-1)+DCPM_recover(k);%每一项等于前一项加上这一项
    end
    cursorpos=1;%光标
    for m=1:floor(row/8)
        for n=1:floor(col/8)%分块恢复           
            %result((m-1)*8+1,(n-1)*8+1)=DCPM_recover((m-1)*8+n);%得到每个块的第一个数的大小
            %下面从变长编码矩阵中获取每一位的具体值
            listedblock=zeros(1,64);
            listedblock(1,1)=DCPM_recover((m-1)*(col/8)+n);
            listedblock_end=1;
            while(~(RLE(cursorpos,1)==0&&RLE(cursorpos,2)==0)&&(m==RLE(cursorpos,3)&&(n==RLE(cursorpos,4))))%直到遇到终结符（0，0）为止
                zero_count=RLE(cursorpos,1);%本位之前0的个数
                value=RLE(cursorpos,2);%本位的值的大小
%                 for i=1:zero_count
%                     listedblock(listedblock_end+1)=0;%补zero_count个0
%                     listedblock_end=listedblock_end+1;
%                 end
                if(zero_count~=0)
                    listedblock_end=listedblock_end+zero_count;
                end

                listedblock(listedblock_end+1)=value;
                listedblock_end=listedblock_end+1;
                cursorpos=cursorpos+1;

            end
            cursorpos=cursorpos+1;%跳过为（0，0）的项
            
            for i=1:64
                t=listedblock(1,i);
                position_x=Z_Scan_Table_Inversed(2,i);
                position_y=Z_Scan_Table_Inversed(3,i);

                result((m-1)*8+position_x,(n-1)*8+position_y)=t;
            end
            
        end
    end
    Matrix=result;
    J=DCPM_recover;
    K=listedblock;


end