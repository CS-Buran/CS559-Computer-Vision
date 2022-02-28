input = imread('lake.jpg');
img = input;
for height = 1:size(img,1)
    for width = 1:size(img,2)
        if img(height,width,1) > 170 || img(height,width,2) < 60 || img(height,width,3) > 120
            %RGB if red<85 or greewidth>100 or Blue >100
            img(height,width,:) = [0 0 0]; 
            %replace the selected pixel with  black
       end
   end
end

gray = rgb2gray(img); % any of the nonblack pixels get turned gray to allow for sobel mask

BW = edge(gray,'sobel'); %applies sobel masks on edges 

cEdge = reshape(uint8([0 255 255]),[1,1,3]) .* uint8(BW); 
%changes the color of the edges on the sobel mask 
%[0 255 255] change this for different colors
imshow(input+cEdge); %output the original image with the colored edge

