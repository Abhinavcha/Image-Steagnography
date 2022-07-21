%Implementing Secure Steganography

clc;
clear all;

close all;
tic;

%img  = imread('deer4.jpg');
img  = imread('greens.jpg'); %Get the input image 
img  = rgb2gray(img);      %Convert to grayscale image if color image
img=imresize(img, [256 256]);

img  = double(img);


figure,imshow(uint8(img)),title('Original Image');
[p, q] = size(img);

N1 = imread('D:\personal\PMS 2022-23\devesh sir\\2020.jpg'); % Reading the Secret image
N1=rgb2gray(N1);
%N1 = double(imread('baby.bmp')); % Reading the Secret image
%N1 = imread('NAME.bmp'); % Reading the Secret image
%N1=N1/1.4;
N1 = imresize(N1,size(img));
figure,imshow(uint8(N1)),title('Original Watermark'); % Displaying the watermark
%img  = double(N1);

[psnr,mse] = psnr(img,N1,p,q);

% calculate the Normalized Correlation
%Nc = nc(img,N1)

[AD] = ad(img,N1,p,q); % find average difference
[SC] = sc(img,N1,p,q); % find Stractural content
[MD]= md(img,N1,p,q);  % find maximum difference
AD;
SC;

MD;
 MD=double(MD);
%MD=uint8(MD)



toc;
