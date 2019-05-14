function out = extract_coords(matches,frames)

%This function does nothing of importance other than manipulating data.
for i = 1:length(matches)
    tmp_sift_index_first_img = matches{i};
    tmp_sift_index_first_img = tmp_sift_index_first_img(1,:);
    
    tmp_sift_coords_first_image = frames{i};
    tmp_sift_coords_first_image = tmp_sift_coords_first_image(1:2,:);
    
    tmp_keypoint_coords_first_image = tmp_sift_coords_first_image(:,tmp_sift_index_first_img, :);
    
    tmp_sift_index_second_img = matches{i};
    tmp_sift_index_second_img = tmp_sift_index_second_img(2,:);
    
    tmp_sift_coords_second_image = frames{i+1};
    tmp_sift_coords_second_image = tmp_sift_coords_second_image(1:2,:);
    
    tmp_keypoint_coords_second_image = tmp_sift_coords_second_image(:,tmp_sift_index_second_img);
    
    out{i} = [tmp_keypoint_coords_first_image; tmp_keypoint_coords_second_image];
end