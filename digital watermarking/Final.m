clf;
clear ; close all;
Image = imread("2020.jpg");
figure; imshow(Image), title("Secret Image");
[Image_Height,Image_Width,Number_Of_Colour_Channels] = size(Image);

Block_Size = 40;
Number_Of_Blocks_Vertically = ceil(Image_Height/Block_Size);
Number_Of_Blocks_Horizontally = ceil(Image_Width/Block_Size);
Image_Blocks = struct('Blocks',[]);

Index = 1;
for Row = 1: +Block_Size: Number_Of_Blocks_Vertically*Block_Size
    for Column = 1: +Block_Size: Number_Of_Blocks_Horizontally*Block_Size
        
    Row_End = Row + Block_Size - 1;
    Column_End = Column + Block_Size - 1;
        
    if Row_End > Image_Height
       Row_End = Image_Height;
    end
    
    if Column_End > Image_Width
       Column_End = Image_Width;
    end
    
    Temporary_Tile = Image(Row:Row_End,Column:Column_End,:);
    
    %Storing blocks/tiles in structure for later use%
    Image_Blocks(Index).Blocks = Temporary_Tile;
    subplot(Number_Of_Blocks_Vertically,Number_Of_Blocks_Horizontally,Index); imshow(Temporary_Tile);
    Index = Index + 1;
   
    
    end  
end
x=double(imread('new secret1.jpg'));

figure; imshow(x/255), title('Original image');

y=x;
a=Image;
save m.dat a -ascii

x1=x(:,:,1); %extracting RGB channel
x2=x(:,:,2);
x3=x(:,:,3);

dx1=dct2(x1); dx11=dx1;  %Discrete cosine transformation in RGB channel
dx2=dct2(x2); dx22=dx2;
dx3=dct2(x3); dx33=dx3;

load m.dat %Loading image after applying DCT    
g=10; %Intensity of embedding
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



figure; imshow(y/255), title('Final image after Encryption');


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
Reconstructed_Image = zeros(size(Image));

Block_Index = 1; 
for Row = 1: +Block_Size: Image_Height
    for Column = 1: +Block_Size: Image_Width
        
        Height_Of_Block = size(Image_Blocks(Block_Index).Blocks,1);
        Width_Of_Block = size(Image_Blocks(Block_Index).Blocks,2);
        Reconstructed_Image(Row:Row+Height_Of_Block-1,Column:Column+Width_Of_Block-1,:) = Image_Blocks(Block_Index).Blocks;
        Block_Index = Block_Index + 1;

    end  
end

figure, imshow(uint8(Reconstructed_Image));
peaksnr = psnr(Image,Reconstructed_Image);
mse = immse(Image,Reconstructed_Image);


