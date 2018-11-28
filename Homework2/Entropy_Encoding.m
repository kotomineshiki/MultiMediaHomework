function [ DPCM_encoded ,RLE_encoded_1,RLE_encoded_2 ] =Entropy_Encoding( DPCM ,RLE )%���������� ����һ��DPCMһά�����RLE���飬

%����RLE��һ�еĴ�С
charset=0:9;%size���ż�
input_RLE_1=RLE(:,1);
[y,x]=size(input_RLE_1);
p=zeros(1,10);

list_of_size=floor(log2(abs(input_RLE_1)))+1;
for i=1:y
    if(list_of_size(i)<-9999)%ɸѡ��������
            list_of_size(i)=0;
    end
end
for i=1:10
    p(i)=length(find(list_of_size==charset(i)))/y;
end
[huffman_dictionary,average]=huffmandict(charset,p);
RLE_encoded_1 = huffmanenco(input_RLE_1,huffman_dictionary); %����

%RLE��һ�м������


end