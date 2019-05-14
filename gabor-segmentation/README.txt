Instructions on How to Run the Script
The script can be run via main.m. Make sure that the following directories exist in the root directory of the script before running the script, and also make sure that everything is added to the PATH of MATLAB.
/data: This directory should have all the dataset images. Their names do not matter.
/out: This directory will be used to output the images that are on the report.
/out/gabor: This directory will be used to output the Gabor filter responses of all images.
/out/segmentation: This directory will be used to output the segmentation results for superpixel segmentation
/out/segmentation: This directory will be used to output the k-means segmentation based on the average Gabor features of superpixels, both as masks and overlay images.
Create these directories by hand. The script does not create them automatically, for the sake of the cleanliness of the filesystem.