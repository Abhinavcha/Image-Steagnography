% Calculates the PSNR (Peak Signal to Noise Ratio) 
%            of images A and A', both of size MxN 
 
function [MD] = md(image,image_prime,M,N)
 
    % convert to doubles
    image=double(image);
    image_prime=double(image_prime);
 
    % avoid divide by zero nastiness 
    if ((sum(sum(image-image_prime))) == 0)
        error('Input vectors must not be identical')
    else
                                                       
       
  
         md=(max(max((image-image_prime)/M*N))); 
       
	MD=md;
        
	
                                    % calculate AD
    end 
 
return