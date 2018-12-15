clc, clear;
originimg=imread('animal_cartoon.jpg');
subplot(121);imshow(originimg);title('ԭͼ');          %��ʾԭͼ
 
 
img_in_ycbcr = rgb2ycbcr(originimg);             % rgbת����YCbCr
[row,col,~]=size(img_in_ycbcr);       % �õ���С��~��ʾ3��ͨ������1��
 
 
%��ͼ����б�Ե��չ
row_expand=ceil(row/16)*16;        %��������չ��16�ı���
if mod(row,16)~=0            %�����һ�н�����չ
    for i=row:row_expand
        img_in_ycbcr(i,:,:)=img_in_ycbcr(row,:,:);
    end
end
col_expand=ceil(col/16)*16;  %������ȡ��
if mod(col,16)~=0         %�����һ�н�����չ
    for j=col:col_expand
        img_in_ycbcr(:,j,:)=img_in_ycbcr(:,col,:);
    end
end
 
 
%��Y,Cb,Cr��������4:2:0����
Y=img_in_ycbcr( : , : ,1);                    %Y����
Cb=zeros(row_expand/2,col_expand/2);       % Cb����
Cr=zeros(row_expand/2,col_expand/2);        %Cr����
for i=1:row_expand/2
    for j=1:2:col_expand/2-1          %������ �����CrCb�������
        Cb(i,j)=double(img_in_ycbcr(i*2-1,j*2-1,2));     
        Cr(i,j)=double(img_in_ycbcr(i*2-1,j*2+1,3));     
    end
end
for i=1:row_expand/2
    for j=2:2:col_expand/2            %ż����
        Cb(i,j)=double(img_in_ycbcr(i*2-1,j*2-2,2));     
        Cr(i,j)=double(img_in_ycbcr(i*2-1,j*2,3));     
    end
end
 
 
 
%������
Y_Quantize_Table=[%����������
    16  11  10  16  24  40  51  61
    12  12  14  19  26  58  60  55
    14  13  16  24  40  57  69  56
    14  17  22  29  51  87  80  62
    18  22  37  56  68 109 103  77
    24  35  55  64  81 104 113  92
    49  64  78  87 103 121 120 101
    72  92  95  98 112 100 103  99];
CbCr_Quantize_Table=[%ɫ��������
    17, 18, 24, 47, 99, 99, 99, 99;
    18, 21, 26, 66, 99, 99, 99, 99;
    24, 26, 56, 99, 99, 99, 99, 99;
    47, 66, 99 ,99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99];
 
Quantize_Factor=0.5;%�������ӡ�ԽС����Խ���ļ�Խ��
 
%������ͨ���ֱ�DCT������
Y_dct_q=DCT_Quantize(Y,Y_Quantize_Table,Quantize_Factor);
Cb_dct_q=DCT_Quantize(Cb,CbCr_Quantize_Table,Quantize_Factor);
Cr_dct_q=DCT_Quantize(Cr,CbCr_Quantize_Table,Quantize_Factor);



%������ͨ���ֱ�����γ�����
Y_RLE=Run_Length_Encoding(Y_dct_q);
Cb_RLE=Run_Length_Encoding(Cb_dct_q);
Cr_RLE=Run_Length_Encoding(Cr_dct_q);

%������ͨ���ֱ����DPCM����
Y_DPCM=DPCM_Encoding(Y_dct_q);
Cb_DPCM=DPCM_Encoding(Cb_dct_q);
Cr_DPCM=DPCM_Encoding(Cr_dct_q);

Y_Decoded=DPCM_RLE_Decoding(Y_RLE,Y_DPCM,size(Y_dct_q));
Cb_Decoded=DPCM_RLE_Decoding(Cb_RLE,Cb_DPCM,size(Cb_dct_q));
Cr_Decoded=DPCM_RLE_Decoding(Cr_RLE,Cr_DPCM,size(Cr_dct_q));


 
%������ͨ���ֱ������ͷ�DCT
Y_after_inquantize_dct=Inverse_Quantize_Dct(Y_Decoded,Y_Quantize_Table,Quantize_Factor);
Cb_after_inquantize_dct=Inverse_Quantize_Dct(Cb_Decoded,CbCr_Quantize_Table,Quantize_Factor);
Cr_after_inquantize_dct=Inverse_Quantize_Dct(Cr_Decoded,CbCr_Quantize_Table,Quantize_Factor);

%�ָ���YCBCRͼ��
YCbCr_recover(:,:,1)=Y_after_inquantize_dct;
for i=1:row_expand/2
    for j=1:col_expand/2
        YCbCr_recover(2*i-1,2*j-1,2)=Cb_after_inquantize_dct(i,j);
        YCbCr_recover(2*i-1,2*j,2)=Cb_after_inquantize_dct(i,j);
        YCbCr_recover(2*i,2*j-1,2)=Cb_after_inquantize_dct(i,j);
        YCbCr_recover(2*i,2*j,2)=Cb_after_inquantize_dct(i,j);
       
        YCbCr_recover(2*i-1,2*j-1,3)=Cr_after_inquantize_dct(i,j);
        YCbCr_recover(2*i-1,2*j,3)=Cr_after_inquantize_dct(i,j);
        YCbCr_recover(2*i,2*j-1,3)=Cr_after_inquantize_dct(i,j);
        YCbCr_recover(2*i,2*j,3)=Cr_after_inquantize_dct(i,j);
    end
end
 
Final_Result=ycbcr2rgb(YCbCr_recover);
Final_Result(row+1:row_expand,:,:)=[];%ȥ����չ����
Final_Result(:,col+1:col_expand,:)=[];%ȥ����չ����
 
subplot(122);imshow(Final_Result);title('�ع����ͼƬ');
