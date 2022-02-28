input = imread('lena4.png'); %input image

A = padarray(input, [(12),(4)]); %pad the image to make it square
targetSize = [570 570];
rad = centerCropWindow2d(size(A),targetSize);
padIm = imcrop(A,rad); %making image square

p = 2; %order of the filter
r0 = 20; %frequency threshhold

[u,v]=meshgrid(-285:284, -285:284);     %creating 
r = sqrt(u.^2+v.^2);                    %Butterworth Low
BwFl = (1./(1 + (r./ r0).^(2.* p)));    %Pass Filter

imfft=fftshift(fft2(padIm));            %using fft on image
imshow(mat2gray(log(abs(imfft))));      %show the fft 

FilteredIm=imfft.*BwFl;        %applying the filter on image w/ fft
imshow(mat2gray(log(1+abs(FilteredIm)))); % shows the filtered image

InverseFilteredIm=ifft2(FilteredIm);    %inversing the image to get result
imshow(mat2gray(abs(InverseFilteredIm))); %shows result


