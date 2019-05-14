function [matches, scores] = match_images(images_d, threshold)

%Compute matches and scores
for i = 1:length(images_d) - 1
    [matches{i},scores{i}] = vl_ubcmatch(images_d{i},images_d{i+1});
end

%Sort and threshold matches according to their scoress.
for i = 1:length(images_d) - 1
    [score_sorted, idx] = sort(scores{i},'ascend');
    score_thresholded = score_sorted(score_sorted < threshold);
    scores{i} = score_thresholded;
    sorted = matches{i};
    sorted = sorted(:,idx);
    sorted = sorted(:, 1:size(score_thresholded,2));
    matches{i} = sorted;
end

