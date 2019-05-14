function out = gabor_bank(image, sigma, theta)
out = zeros([size(image), length(sigma)*length(theta)]);
    for i=1:length(sigma)
        for j = 1:length(theta)
            filter = gabor_fn(sigma(i),theta(j),10.5,0,1);
            out(:,:,(i-1)*length(theta)+j) = conv2(image,double(filter),'same');
        end
    end
end