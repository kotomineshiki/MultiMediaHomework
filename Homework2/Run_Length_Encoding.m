function [ Matrix ,listedblock] =Run_Length_Encoding( I )%������Ϊһά���飬�ٽ���ת�����γ�����Ķ�ά����
    [row,col]=size(I);%�õ�����Ĵ�С 
    Z_Scan_Table=[%z��ɨ���ת������C++���ߵõ�
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
        for n=1:floor(col/8)%�ֿ鴦��
            listedblock=zeros(1,64);%����һ��һά����

            for i=(m-1)*8+1:(m-1)*8+8
               for j=(n-1)*8+1:(n-1)*8+8

                   position=Z_Scan_Table(i-(m-1)*8,j-(n-1)*8);%�õ�Ӧ���е�λ��

                    listedblock(1,position)=I(i,j);%�����ݷ��õ���Ӧ��λ����
                  
               end
            end
            zero_count=0;%ǰ���0�ĸ���
            %����ת���ɶ�ά����
            for i=2:64%�Ӷ���ʼʱΪ�˷�ֹ��һλ��0�����

                if(listedblock(1,i)==0)
                    zero_count=zero_count+1;
                else
                    %�����ά����
                    
                    result(end+1,:)=[zero_count, listedblock(1,i),m,n];
                    zero_count=0;
                end
            end
            if(zero_count~=0)%��β��Ϊ0
                result(end+1,:)=[0, 0,m,n];%����롾0��0��
            end
        end
    end
    Matrix=result;%���ض�ά����
end