function fin = stitch(images, tforms)
%collect transforms into cumulative form, and keep track of image sizes.
image_sizes = zeros(length(images),2);
cumulative_tforms(length(images)) = affine2d(eye(3));
for i = 2:length(images)
    image_sizes(i,:) = size(images{i});
    cumulative_tforms(i) = tforms{i-1};
    cumulative_tforms(i).T = cumulative_tforms(i).T * cumulative_tforms(i-1).T;
end

%compute the output size of the transformed and superimposed images
%source: FOR THIS SEGMENT ONLY
%https://uk.mathworks.com/help/vision/examples/feature-based-panoramic-image-stitching.html
for i = 1:numel(tforms)
    [xlim(i,:), ylim(i,:)] = outputLimits(cumulative_tforms(i), [1 image_sizes(i,2)], [1 image_sizes(i,1)]);
end
max_image_size = max(image_sizes);
xMin = min([1; xlim(:)]);
xMax = max([max_image_size(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([max_image_size(1); ylim(:)]);
width  = round(xMax - xMin);
height = round(yMax - yMin);
xLimits = [xMin xMax];
yLimits = [yMin yMax];

%initialize the stitched image as a black canvas
fin = zeros([height width], 'like', images{1});
fin_v = imref2d([height width], xLimits, yLimits);
image_count = zeros(size(fin));

%note: implementation uses linear blending
for i = 1:length(images)
    %normalize the image
    I = images{i}/255;
    %warp the next image according to affine transform
    warped_image = imwarp(I,cumulative_tforms(i),'OutputView',fin_v);
    %compute a mask that shows where the image is to be placed
    mask = imwarp(true(size(I,1),size(I,2)), cumulative_tforms(i), 'OutputView', fin_v);
    %keep count of how many images were added to a particular pixel
    image_count = image_count + mask;
    %super-impose transformed image on top of the canvas
    fin = fin + warped_image;  
end
%normalize the intensities
fin = fin ./ image_count;
fin(isnan(fin)) = 0;