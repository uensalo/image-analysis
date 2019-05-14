function [segmented_image_labels, labels, gabor_images] = segment_images(images, N_init, M)
gabor_pixels_superset = [];
for i = 1:length(images)
    [labels{i}, N{i}] = superpixels(images{i}, N_init, 'Method', 'slic0');
    [gabor_pixels{i}, gabor_images{i}] = gabor_features(images{i}, labels{i}, N{i});
    gabor_pixels_superset = [gabor_pixels_superset; gabor_pixels{i}];
end

km_idx = kmeans(gabor_pixels_superset,M, 'Replicate', 5);

start_idx = 1;
end_idx = 0;
for i = 1:length(images)
    end_idx = end_idx + N{i};
    cluster_idx{i} = km_idx(start_idx:end_idx);
    start_idx = end_idx + 1;
end

for i = 1:length(images)
    segmented_img = zeros(size(images{i}, 1), size(images{i},2));
    label_idx = label2idx(labels{i});
    kmeans_idx = cluster_idx{i};
    for j = 1:N{i}
        idx_lin = label_idx{j};
        segmented_img(idx_lin) = kmeans_idx(j);
    end
    segmented_image_labels{i} = segmented_img;
end
end