function out = panaroma(dir_name,type,threshold)
if(strcmp(type, 'sift'))
    out = siftdesc(dir_name,threshold);
elseif(strcmp(type,'raw'))
    out = rawdesc(dir_name,threshold);
end