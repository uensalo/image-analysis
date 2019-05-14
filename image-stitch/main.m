%set up vlfeat
run('src\vlfeat\toolbox\vl_setup.m');
clear;

stitched = panaroma('goldengate\goldengate','raw',inf);
%stitched = panaroma('cs484_hw2_data\fishbowl\fishbowl','raw',inf);
imshow(stitched);