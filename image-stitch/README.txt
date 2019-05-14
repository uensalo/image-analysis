Name: Unsal Ozturk
ID: 21601565
External libraries used: VLFeat
Link: http://www.vlfeat.org/install-matlab.html
Instructions:
In order to get the code running, the VLFeat library should be placed as follows in the root directory:
src\vlfeat

which should contain the binaries required for the MATLAB installation of VLFeat. In particular, the script 
runs the following command on start-up, which ensures that VLFeat is installed.
run('src\vlfeat\toolbox\vl_setup.m');

Essentially, the script won’t work without the VLFeat binaries specifically placed inside the root directory 
in the described way. After installing VLFeat, one can call the script I wrote using the “panaroma(3)” 
function, which takes in three parameters. The first parameter is the name of the directory and the pattern 
of the image files that are to be stitched. The second parameter is a string, which should only take the values:
'sift'
'raw'
This parameter determines the descriptor that will be used to compute affine transformations from one image to 
another. The first parameter makes use of the SIFT descriptor while the second parameter uses a chi-squared-
distance based raw grayscale pixel histogram descriptor (use with caution, causes memory issues sometimes!).
The third parameter is the threshold for the descriptor match scores. Any feature match higher than the specified
 threshold is discarded. This prevents noisy features to be influential in the panorama construction process.
Here is an example invocation of the function:
stitched = panaroma('goldengate\goldengate','sift',500);

This essentially constructs a panaroma from the images with the pattern “goldengate/goldengate-xx.png”
using the SIFT descriptor and discards features that have a SSD higher than 500.
