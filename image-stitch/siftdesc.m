function stitched = siftdesc(directory_name, threshold)
%read images from the folders. Note that they have to be placed in those
%directories.
images = read_images(directory_name);

%compute sift frames and descriptors
[f,d] = compute_sift(images);

%compute the matches between successive images along with their scores
%the matches are thresholded with respect to their scores
[m, s] = match_images(d,threshold);

%extract the coordinates of the matched features
coords = extract_coords(m, f);

%compute affine transformations between images
trafo = compute_transforms(coords);

%stitch the images according to their cascading affine transformations
stitched = stitch(images, trafo);

