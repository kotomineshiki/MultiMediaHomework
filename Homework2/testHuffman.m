charset=0:9;%size���ż�
input=Y_RLE(:,1);
[y,x]=size(input);
p=zeros(1,10);

list_of_size=floor(log2(abs(input)))+1;
for i=1:y
    if(list_of_size(i)<-9999)%ɸѡ��������
            list_of_size(i)=0;
    end
end
for i=1:10
    p(i)=length(find(list_of_size==charset(i)))/y;
end
[huffman_dictionary,average]=huffmandict(charset,p);
encoded_list_of_size = huffmanenco(list_of_size,huffman_dictionary); %�õ�size�ı��룬����Ҫ�ü����ȵı���
binary_code=dec2bin(abs(input),8);%�õ�ԭ������Ķ�������ʽ
cutted_string='';
temp;
for i=1:y
    N=list_of_size(i);
    if(input(i)<0)%��������С��0����
        temp=bitxor(2^N+abs(input(i)),N);%ȡ��
    else
        temp=dec2bin(abs(input(i)),N);
    end%��ʱӦ�õõ������еķ���
    %disp(temp);
    cutted_string=strcat(cutted_string,temp);
end
decoded_list_of_size=huffmandeco(encoded_list_of_size,huffman_dictionary);%����˳��ȵ����飬����������Էָ�cutted_string





% [huffman_dictionary,average]=huffmandict(charset,p);
% enco = huffmanenco(input,huffman_dictionary); %����
% deco = huffmandeco(enco,huffman_dictionary); %����