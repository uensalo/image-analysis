clear
clc

N_init = 200;
img_dir = dir('data/*.JPG');

for i = 1:length(img_dir)
    images{i} = imread(img_dir(i).name);
end

[segmented, labels, gabor_images] = segment_images(images, 2048, 4);

for i = 1:length(img_dir)
    a = figure;
    mask1 = boundarymask(labels{i});
    imshow(imoverlay(images{i},mask1,'red'));
    title(strcat('Superpixel Segmentation: ', img_dir(i).name));

    b = figure;
    mask2 = boundarymask(segmented{i});
    imshow(imoverlay(images{i},mask2,'red'));
    title(strcat('Gabor Feature Segmentation: ', img_dir(i).name));
    
    c = figure;
    alpha = images{i};
    h = imshow(label2rgb(segmented{i}));
    set(h, 'AlphaData', rgb2gray(alpha));
    title(strcat('Segmentation False Color Overlay: ', img_dir(i).name));

    saveas(a, strcat('out/superpixel/superpixel_image', int2str(i), '.png'));
    saveas(b, strcat('out/segmentation/seg_image', int2str(i), '.png'));
    saveas(c, strcat('out/segmentation/false_color_seg_image', int2str(i), '.png'));
end

for n = 1:length(img_dir)
    gabor_sv = gabor_images{n};
    for i = 1:4
        for j = 1:4
            a = figure('visible', 'off');
            imshow(gabor_sv(:,:,(i-1)*4+j));
            title(strcat('Gabor Response for Image', img_dir(n).name , ', Scale ', int2str(i), ' Orientation ', int2str(45 * (j - 1))));
            saveas(a,strcat('out/gabor/gabor_', int2str(n),'_', int2str(i), int2str(j), '.png'));
        end
    end
end



