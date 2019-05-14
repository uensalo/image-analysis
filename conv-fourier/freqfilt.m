function f = freqfilt(filter, image)
% take fft of image
fftimage = fft2(image);
% first pad the filter, then take its fft
fftfilter = zeros(size(image));
fftfilter(1:size(filter, 1), 1: size(filter, 2)) = filter;
fftfilter = fft2(fftfilter);
% convolution theorem
freq_filtered = fftimage .* fftfilter;
f = ifft2(freq_filtered);