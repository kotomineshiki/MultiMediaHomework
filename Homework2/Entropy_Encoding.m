function [ DPCM_encoded ,RLE_encoded_1,RLE_encoded_2 ] =Entropy_Encoding( DPCM ,RLE )%哈夫曼编码 传入一个DPCM一维数组和RLE数组，

%计算RLE第一列的大小
charset=0:9;%size符号集
input_RLE_1=RLE(:,1);
[y,x]=size(input_RLE_1);
p=zeros(1,10);

list_of_size=floor(log2(abs(input_RLE_1)))+1;
for i=1:y
    if(list_of_size(i)<-9999)%筛选出负无穷
            list_of_size(i)=0;
    end
end
for i=1:10
    p(i)=length(find(list_of_size==charset(i)))/y;
end
[huffman_dictionary,average]=huffmandict(charset,p);
RLE_encoded_1 = huffmanenco(input_RLE_1,huffman_dictionary); %编码

%RLE第一列计算完毕


end