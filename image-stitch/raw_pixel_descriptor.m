function desc = raw_pixel_descriptor(images, frames, window_size)

%Warning: VERY inefficient. Causes memory problems. Even if one manages to
%compute the descriptors, the results are usually horrible due to boundary
%conditions.
for n = 1:length(images)
    descriptor_entry = zeros(256, size(frames{n},2));
    cur_frame = frames{n};
    I = images{n};
    [size_x, size_y] = size(I);
    I = padarray(I,[size_x, size_y],'both');
    
    for i = 1:size(frames{n},2)
        x = round(cur_frame(1,i)) + size_y;
        y = round(cur_frame(2,i)) + size_x;
        scale = cur_frame(3,i);
        orientation = cur_frame(4,i);
        
        square_size = 2*ceil(scale);
        patch = I(y-square_size:y+square_size, x-square_size:x+square_size);
        patch = imrotate(patch, -180*orientation/pi);
        [cx,cy] = size(patch);
        cx = ceil(cx/2);
        cy = ceil(cy/2);
        patch = patch(cx-ceil(square_size):cx+ceil(square_size),cy-ceil(square_size):cy+ceil(square_size));

        descriptor_entry(:,i) = imhist(patch/255);
        %pure black pixels do NOT count, as they are part of the padding
        %descriptor_entry(1,i) = 0;
    end
    desc{n} = descriptor_entry;
end