% Calculates the PSNR (Peak Signal to Noise Ratio) 
%            of images A and A', both of size MxN 
 
function [A,mse] = psnr(x,a,M,N)
 
    % convert to doubles
    x=double(x);
    a=double(a);
 
    % avoid divide by zero nastiness 
    if ((sum(sum(x-a))) == 0)
        error('Input vectors must not be identical')
    else
        psnr_num=M*N*max(max(x.^2));                % calculate numerator 
        psnr_den=sum(sum((x-a).^2));      % calculate denominator    
        mse = psnr_den;
        A=10*log10(psnr_num/psnr_den);                            % calculate PSNR 
    end 
 
return