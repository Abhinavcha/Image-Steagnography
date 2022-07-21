% Calculates the PSNR (Peak Signal to Noise Ratio) 
%            of images A and A', both of size MxN 
 
function [SC] = sc(image,image_prime,M,N)
 
    % convert to doubles
    image=double(image);
    image_prime=double(image_prime);
 
    % avoid divide by zero nastiness 
    if ((sum(sum(image-image_prime))) == 0)
        error('Input vectors must not be identical')
    else
                                                      % calculate numerator 
        sc1=(sum(sum((image).^2)));      % calculate sc1 for cover image 
        sc2=(sum(sum((image_prime).^2)));       % sc2 for stego
  
         
        SC = sc1/sc2;
                                    % Stractural content
    end 
 
return