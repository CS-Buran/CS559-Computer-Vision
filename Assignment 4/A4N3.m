input = imread('lena.png'); %input image
padIm = padarray(input, [(0),(2)]); %pad the image to make it square

r0 = 18; %frequency threshhold
[u,v]=meshgrid(-218:217, -218:217);     %Creating
X = (-(u.^2 + v.^2) ./ (2.* r0.^2));    %Gaussian Low 
gLp = exp(X);                           %Pass Filter

imfft=fftshift(fft2(padIm));%using fft on image
imshow(mat2gray(log(abs(imfft)))); %show the fft 

FilteredIm=imfft.*gLp;%applying the filter on image w/ fft
imshow(mat2gray(log(1+abs(FilteredIm))));% shows the filtered image

InverseFilteredIm=ifft2(FilteredIm);%inversing the image to get result
imshow(mat2gray(abs(InverseFilteredIm)));%show result
