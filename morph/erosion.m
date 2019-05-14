% erosion: if structuring element fits, then 1
function out = erosion(image, str_elem)
% pad the image with zeroes to avoid dimension loss
padx = floor(size(str_elem,1)/2);
pady = floor(size(str_elem,2)/2);
[N,M] = size(image);

out = zeros(size(image));

padded_image = zeros(N+2*padx, M+2*pady);
padded_image(padx+1:N+padx, pady+1:M+pady) = image;

% loop over the pixels of the image
for i = padx+1: padx+N
    for j = pady+1:pady+M
        img_seg = padded_image(i-padx:i+padx, j-pady:j+pady);
        intersection = img_seg .* str_elem;
        % if the structuring element "fits", then the logical and of the
        % structuring element and the image segment should be equal to the
        % structuring element itself.
        if isequal(str_elem,intersection)
            out(i-padx,j-pady) = 1;
        end
    end
end