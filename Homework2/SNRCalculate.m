function [mse,psnr] = SNRCalculate(image,image_prime)
% convert to doubles
image=double(image) ;
[M,N]=size(image) ;
image_prime=double(image_prime) ;
% avoid divide by zero nastiness
if ((sum(sum((image-image_prime).^2))) == 0) 
error('Input vectors must not be identical');
else
mse=sum(sum((image-image_prime).^2))/(M*N); 
psnr=10*log10(255^2/mse) ;
end
return