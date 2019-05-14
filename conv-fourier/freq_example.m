clear
clc
im = imread('pcb.png');
im = im2double(rgb2gray(im));
%display image
figure
imshow(im);
lpf = fspecial('gaussian', 21, 6);
%display fourier response of lpf(gaussian)
figure
fftfilter = zeros(size(im));
fftfilter(1:size(lpf, 1), 1: size(lpf, 2)) = lpf;
fftfilter = fft2(fftfilter);
imshow(abs(fftshift(fftfilter)));

%display frequency response of log log image
figure
imshow(log(abs(log(freqresponse(im)))));

im = freqfilt(lpf, im);
%display blurred image
figure
imshow(im);

%display lpf(gaussian) in spatial domain
figure
imshow(lpf);

%display log of image frequency response
figure
imshow(log(freqresponse(im)));

