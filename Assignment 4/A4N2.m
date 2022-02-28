input = imread('Fingerprint.png'); %input image

A = padarray(input, [(1),(0)]); %pad the image to make it square
r0 = 10; %frequency threshhold
w = 1;
[u,v]=meshgrid(-99:98, -99:98);         %creating    
Y = (-(4.*w.*r0.^2) ./ (u.^2 + v.^2));  %Gaussian Low
GBS = exp(Y);                           %Pass Filter

imfft=fftshift(fft2(A));            %using fft on image
imshow(mat2gray(log(abs(imfft))));      %show the fft 

FilteredIm=imfft.*GBS;        %applying the filter on image w/ fft
imshow(mat2gray(log(1+abs(FilteredIm)))); % shows the filtered image

InverseFilteredIm=ifft2(FilteredIm);    %inversing the image to get result
imshow(mat2gray(abs(InverseFilteredIm))); %shows result
