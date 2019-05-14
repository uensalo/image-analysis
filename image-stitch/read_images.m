function images = read_images(dir_name)

%Use pattern matching to neatly read images from a directory.
imagefiles = dir(strcat(dir_name,'*.png'));      
nfiles = length(imagefiles);
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = single(imread(currentfilename));
   images{ii} = currentimage;
end