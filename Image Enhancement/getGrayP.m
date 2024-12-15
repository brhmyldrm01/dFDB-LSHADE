function [ p ] = getGrayP(image)

global_mean = mean(image(:));
B = mean_n(image);
C = std_n(image,B);
im_size = size(image);
p = {global_mean, B, C, im_size, image};

end