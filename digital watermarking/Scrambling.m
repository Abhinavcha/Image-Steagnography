clf;
Image = imread("new secret1.jpg");
figure, imshow(Image);
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


%reconstruction
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
