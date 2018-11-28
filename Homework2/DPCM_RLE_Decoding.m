function [ Matrix ,J,K] =DPCM_RLE_Decoding( RLE,DCPM , Matrix_size)%�ѵõ����γ������DPCM�������ϣ��ָ���֮ǰ��״̬.size ��ԭͼ�Ĵ�С
    Z_Scan_Table=[%z��ɨ���ת��������C++���ߵõ�
        1 2 6 7 15 16 28 29 
        3 5 8 14 17 27 30 43 
        4 9 13 18 26 31 42 44 
        10 12 19 25 32 41 45 54 
        11 20 24 33 40 46 53 55 
        21 23 34 39 47 52 56 61 
        22 35 38 48 51 57 60 62 
        36 37 49 50 58 59 63 64];
   
Z_Scan_Table_Inversed=zeros(3,64);%�õ���任��
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
    for k=1:DCPMLength%����DCPM
        if(k==1)
            continue;
        end
        DCPM_recover(k)=DCPM_recover(k-1)+DCPM_recover(k);%ÿһ�����ǰһ�������һ��
    end
    cursorpos=1;%���
    for m=1:floor(row/8)
        for n=1:floor(col/8)%�ֿ�ָ�           
            %result((m-1)*8+1,(n-1)*8+1)=DCPM_recover((m-1)*8+n);%�õ�ÿ����ĵ�һ�����Ĵ�С
            %����ӱ䳤��������л�ȡÿһλ�ľ���ֵ
            listedblock=zeros(1,64);
            listedblock(1,1)=DCPM_recover((m-1)*(col/8)+n);
            listedblock_end=1;
            while(~(RLE(cursorpos,1)==0&&RLE(cursorpos,2)==0)&&(m==RLE(cursorpos,3)&&(n==RLE(cursorpos,4))))%ֱ�������ս����0��0��Ϊֹ
                zero_count=RLE(cursorpos,1);%��λ֮ǰ0�ĸ���
                value=RLE(cursorpos,2);%��λ��ֵ�Ĵ�С
%                 for i=1:zero_count
%                     listedblock(listedblock_end+1)=0;%��zero_count��0
%                     listedblock_end=listedblock_end+1;
%                 end
                if(zero_count~=0)
                    listedblock_end=listedblock_end+zero_count;
                end

                listedblock(listedblock_end+1)=value;
                listedblock_end=listedblock_end+1;
                cursorpos=cursorpos+1;

            end
            cursorpos=cursorpos+1;%����Ϊ��0��0������
            
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