clear
clc
% read in image
image = im2double(imread('sonnet.png'));
imout = image;

% Obvious stuff: there is a light source in the upper right corner of the 
% image. Assume a point light at (x,y,z), with radial intensity I. Play
% with the parameters and undo the lighting so that the lighting on the 
% bottom of the image is similar to the lighting at the top right corner.
% The model is L = I/d^2*cos(theta)*albedo/(2*pi), assuming the surface is
% perfectly diffuse. We are interested in the albedo of the surface. The
% ink will have a blacker albedo whereas the paper will have a whiter
% albedo. Solving the equation, one has albedo = L/I*d^2/cos(theta)*2*pi.
% One can directly omit 2*pi and incorporate it into I for practical
% purposes. Now, one should play with the parameters x,y,z and I below to
% obtain an image composed purely of the albedo of the surface.
%
% DRAWBACKS: There may be more than one light source in the scene. The
% reflections might not be perfectly diffuse.

x = 275;
y = -20;
z = 375;
C = 200000;

for i=1:size(imout,1)
    for j=1:size(imout,2)
        d2_plane = (i-y)^2+(j-x)^2;
        d2_space = d2_plane + z^2;
        cosTheta = z/d2_space^0.5;
        imout(i,j) = image(i,j) * d2_space / C / cosTheta;
    end
end

figure
imshow(imout);
imout = exp(-exp(imout));
threshold = adaptthresh(imout, 0.48);
imbit = imbinarize(imout, threshold);
figure
imshow(imbit);

str_elem = [0,1,0;
            1,1,1;
            0,1,0;];
        
dilated = dilation(imbit,str_elem);

figure
imshow(dilated - imbit);
eroded = erosion(imbit,str_elem);
final = (dilated-imbit+eroded);

figure
imshow(final);
