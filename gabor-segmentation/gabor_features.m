function [gabor_sup, gabor_resp] = gabor_features(image, labels, N)
image_gray = im2double(rgb2gray(image));
eo = gabor_bank(image_gray, [1 2 3 4], [0 45 90 135]);
gabor_resp = eo;
gabor_mag = eo;

idx = label2idx(labels);
sz = size(image_gray);
gabor_sup = zeros(size(gabor_mag,3),N);
for i = 1:N
    idx_lin = idx{i};
    [x,y] = ind2sub(sz, idx_lin);
    rws = [x,y];
    for j = 1:size(rws,1)
        gabor_response = gabor_mag(rws(j,1),rws(j,2),:);
        gabor_sup(:,i) = gabor_sup(:,i) + gabor_response(:);
    end
    gabor_sup(:,i) = gabor_sup(:,i) / size(rws,1);
end

gabor_sup = gabor_sup';