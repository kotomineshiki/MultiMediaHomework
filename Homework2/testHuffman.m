charset=0:9;%size符号集
input=Y_RLE(:,1);
[y,x]=size(input);
p=zeros(1,10);

list_of_size=floor(log2(abs(input)))+1;
for i=1:y
    if(list_of_size(i)<-9999)%筛选出负无穷
            list_of_size(i)=0;
    end
end
for i=1:10
    p(i)=length(find(list_of_size==charset(i)))/y;
end
[huffman_dictionary,average]=huffmandict(charset,p);
encoded_list_of_size = huffmanenco(list_of_size,huffman_dictionary); %得到size的编码，下面要裁剪幅度的编码
binary_code=dec2bin(abs(input),8);%得到原先数组的二进制形式
cutted_string='';
temp;
for i=1:y
    N=list_of_size(i);
    if(input(i)<0)%对于所有小于0的数
        temp=bitxor(2^N+abs(input(i)),N);%取反
    else
        temp=dec2bin(abs(input(i)),N);
    end%此时应该得到了所有的幅度
    %disp(temp);
    cutted_string=strcat(cutted_string,temp);
end
decoded_list_of_size=huffmandeco(encoded_list_of_size,huffman_dictionary);%获得了长度的数组，利用这个可以分割cutted_string





% [huffman_dictionary,average]=huffmandict(charset,p);
% enco = huffmanenco(input,huffman_dictionary); %编码
% deco = huffmandeco(enco,huffman_dictionary); %解码