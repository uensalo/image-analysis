% dilation: if structuring element hits, then 1.
function out = dilation(image, str_elem)
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
        % logical intersection is analogous to element-wise multiplication
        intersection = img_seg .* str_elem;
        % if the structuring element "hits", then at least one element
        % in intersection is non-zero.
        if sum(sum(intersection)) > 0
            out(i-padx,j-pady) = 1;
        end
    end
end