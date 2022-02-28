img = imread("apple.JPG"); %reads image
imgN = uint8(img/64) * 64;
imshow(imgN);