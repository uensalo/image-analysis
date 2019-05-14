im = imread('pcb.png');
im = im2double(rgb2gray(im));

sobelx = [-1,0,1;-2,0,2;-1,0,1];
sobely = [-1,0,1;-2,0,2;-1,0,1]';

Ix = convolution(sobelx, im);
Iy = convolution(sobely, im);

grad = (Ix.^2 + Iy.^2).^(1/2);

imshow(grad);