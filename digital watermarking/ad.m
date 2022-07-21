% Calculates the PSNR (Peak Signal to Noise Ratio) 
%            of images A and A', both of size MxN 
 
function [AD] = ad(image,image_prime,M,N)
 
    % convert to doubles
    image=double(image);
    image_prime=double(image_prime);
 
    % avoid divide by zero nastiness 
    if ((sum(sum(image-image_prime))) == 0)
        error('Input vectors must not be identical')
    else
                                                      % calculate numerator 
        %ad=(sum(sum(image-image_prime))/M*N);      % calculate denominator  psnr den say AD 



  
         %ad=((sum(sum(image-image_prime)))/M*N); 
diff= image-image_prime;

ad=sum(diff);
AD=sum(ad);
AD=AD/(M*N);

       
                                    % calculate AD
    end 
 
return