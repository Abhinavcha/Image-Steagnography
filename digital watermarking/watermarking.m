clear ; close all;

x=double(imread('greens.jpg'));

figure; imshow(x/255), title('Original image');

y=x;

a=zeros(168,300); %creating image to be embedded
a(80:150,80:150)=1;

figure; imshow(a), title('Secret Image');

save m.dat a -ascii

x1=x(:,:,1); %extracting RGB channel
x2=x(:,:,2);
x3=x(:,:,3);

dx1=dct2(x1); dx11=dx1;  %Discrete cosine transformation in RGB channel
dx2=dct2(x2); dx22=dx2;
dx3=dct2(x3); dx33=dx3;

load m.dat %Loading image after applying DCT    
g=1000; %Intensity of embedding
[rm,cm]=size(m); %rows and column size 

dx1(1:rm,1:cm)=dx1(1:rm,1:cm)+g*m;
dx2(1:rm,1:cm)=dx2(1:rm,1:cm)+g*m;
dx3(1:rm,1:cm)=dx3(1:rm,1:cm)+g*m;

figure,imshow(dx1), title('R component of image after DCT');
figure,imshow(dx2), title('B component of image after DCT');
figure,imshow(dx3), title('G component of image after DCT');


y1=idct2(dx1); %INVERSE DCT
y2=idct2(dx2);
y3=idct2(dx3);

y(:,:,1)=y1;
y(:,:,2)=y2;
y(:,:,3)=y3;

figure, imshow(y1), title('Image in which encryption is done');
figure, imshow(y2), title('Image in which encryption is done');
figure, imshow(y3), title('Image in which encryption is done');

figure; imshow(y/255), title('Final image after Encryption');
figure; imshow(abs(y-x)*100), title('Diffrence between original and encrypted image');

%decryption
z=y;
[r,c,s]=size(z);

dy1=dct2(y(:,:,1));
dy2=dct2(y(:,:,2));
dy3=dct2(y(:,:,3));
y=z;

dy1(1:rm,1:cm)=dy1(1:rm,1:cm)-g*m; %Removing secret image
dy2(1:rm,1:cm)=dy2(1:rm,1:cm)-g*m;
dy3(1:rm,1:cm)=dy3(1:rm,1:cm)-g*m;

y11=idct2(dy1);
y22=idct2(dy2);
y33=idct2(dy3);

yy(:,:,1)=y11;
yy(:,:,2)=y22;
yy(:,:,3)=y33;

figure; imshow(yy/255), title('Decrypted image');
figure; imshow(abs(yy-x)*10000), title('Diffrence');
peaksnr=psnr(x,y);
mse=immse(x,y);