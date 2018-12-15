charset=0:9;%size符号集
input=Y_DPCM(1,:);
[x,y]=size(input);
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
%temp;
for i=1:y
    N=list_of_size(1,i);
    if(input(i)<0)%对于所有小于0的数
        temp=bitxor(2^N+abs(input(1,i)),N);%取反
    else
        temp=dec2bin(abs(input(1,i)),N);
    end%此时应该得到了所有的幅度
    %disp(temp);
    cutted_string=strcat(cutted_string,temp);
end
decoded_list_of_size=huffmandeco(encoded_list_of_size,huffman_dictionary);%获得了长度的数组，利用这个可以分割cutted_string


%114763bit(熵编码后的YRLE的Amplitude字符串长度)+380311bit（熵编码后Y的变长编码的size的大小）+20300bit（Cb）+5037bit（熵编码后的CbRLE的Amplitude字符串长度）+17436bit（Cr）+4443bit（熵编码后的CrRLE的Amplitude字符串长度）+


% [huffman_dictionary,average]=huffmandict(charset,p);
% enco = huffmanenco(input,huffman_dictionary); %编码
% deco = huffmandeco(enco,huffman_dictionary); %解码