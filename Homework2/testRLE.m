test=[-14,17,31,9,3,1,-1,1,-52,29,26,-3,-4,-3,-1,-1;14,41,-10,-6,0,-1,-1,0,-15,-26,-15,2,2,1,0,0;-10,8,14,-1,0,0,0,-1,19,7,-1,-1,1,1,1,1;6,-30,1,7,-1,0,1,0,16,-1,5,3,0,-1,-1,0;8,1,-3,1,1,0,-1,1,10,1,-3,-1,0,0,0,0;6,-1,-2,-1,0,1,0,0,4,0,1,1,0,0,0,0;1,1,-1,0,0,0,0,0,3,1,0,0,0,0,0,0;0,-1,0,0,0,1,0,0,0,0,0,0,0,0,0,0;29,51,1,-2,3,-1,0,0,-30,39,-11,-10,4,1,-1,-1;-5,-10,26,-10,1,0,0,0,22,23,4,7,1,-1,0,1;-25,19,8,-5,3,-1,0,0,17,20,-10,-8,0,1,0,-1;-11,6,-1,4,-3,0,1,-1,-5,-7,-7,-1,1,0,-1,0;-4,0,1,1,-1,0,0,0,-4,-1,0,1,1,0,0,0;0,-1,0,1,0,-1,0,0,-1,0,1,1,0,0,0,0;0,0,0,1,0,0,0,0,0,1,1,0,-1,0,0,0;0,0,0,0,0,0,0,0,-1,0,0,-1,0,0,0,0;-37,49,26,1,10,3,0,0,-33,11,-14,-10,-1,1,-1,0;43,15,-11,-16,0,0,-1,0,33,20,-1,-7,1,1,0,0;15,7,-1,-3,1,-1,-1,0,12,17,1,-5,0,0,-1,0;-4,0,1,3,1,-1,0,0,-7,0,-1,0,1,0,0,0;-8,-4,-3,1,0,0,0,0,-7,-6,1,0,0,0,0,0;-1,3,0,1,0,0,0,0,-1,-1,0,-1,-1,0,0,0;0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,1,0;1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
[qq,temp]=Run_Length_Encoding(test);
qq2=DPCM_Encoding(test);

% dict = huffmandict(k,P); %�����ֵ�
 %enco = huffmanenco(I1,dict); %����
% deco = huffmandeco(enco,dict); %����

[final,J,K]=DPCM_RLE_Decoding(qq,qq2,size(test));