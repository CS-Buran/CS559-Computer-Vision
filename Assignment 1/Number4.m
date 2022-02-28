img = imread("IMAGENAME.JPG"); %reads image
imshow(img);
for height = 1:size(img,1)
    for width = 1:size(img,2)
        if img(height,width,1) < 85 || img(height,width,2) > 100 || img(height,width,3) > 100
            %RGB if red<85 or greewidth>100 or Blue >100
            gray = 0.3*img(height,width,1) + 0.59*img(height,width,2) + 0.11*img(height,width,3);
            %grayscale to rgb conversion equation
            img(height,width,:) = [gray gray gray]; 
%replace the selected pixel with  gray
       end
   end
end
imshow(img)
