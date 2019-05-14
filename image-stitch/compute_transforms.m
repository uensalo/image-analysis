function out = compute_transforms(coords)

for i = 1:length(coords)
    %Extract the coordinates in their local coordinate frames
    points1 = coords{i};
    points1 = points1(1:2,:)';
    points2 = coords{i};
    points2 = points2(3:4,:)';
    
    %Compute the affine transform from one coordinate frame to another
    %This algorithm uses a variant of RANSAC to compute an affine transform
    %(Known as MSAC)
    tform = estimateGeometricTransform(points2,points1, 'affine','Confidence',99.9, 'MaxNumTrials',2000);
    out{i} = tform;
end
