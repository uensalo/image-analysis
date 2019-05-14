function cnv = convolution(filter, image)
% flip the filter for convolution
filter_flipped = flip(flip(filter,1),2);
% pad the image with zeroes to avoid dimension loss
padr = floor(size(filter_flipped,1) / 2);
padc = floor(size(filter_flipped,2) / 2);
cnv = zeros(size(image));
zero_pad_img = pad(image, padr, padc);
% convolve the image
for i =  1 + padr:size(zero_pad_img,1) - padr
    for j = 1 + padc:size(zero_pad_img,2) - padc
        img_seg = zero_pad_img(i-padr:i+padr,j-padc:j+padc);
        dt = sum(img_seg .* filter_flipped);
        cnv(i - padr,j - padc) = sum(dt, 2);
    end
end

