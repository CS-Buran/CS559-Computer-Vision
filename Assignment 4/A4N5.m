input = imread('colr.png'); %input image

r = input(:, :, 1);     %seperate the red channel
g = input(:, :, 2);     %seperate the green channel
b = input(:, :, 3);     %seperate the blue channel

redFiltered = medfilt2(r, [6 6]);   %apply median filter on red
greenFiltered = medfilt2(g, [6 6]); %apply median filter on green
blueFiltered = medfilt2(b, [6 6]);  %apply median filter on blue

recombine = cat(3, redFiltered, greenFiltered, blueFiltered); %recombine all channels
imshow(recombine); %output the filtered image
