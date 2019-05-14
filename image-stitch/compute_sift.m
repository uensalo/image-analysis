function [outf, outd] = compute_sift(images)
for i= 1:length(images)
    [f,d] = vl_sift(images{i});
    outf{i} = f;
    outd{i} = d;
end