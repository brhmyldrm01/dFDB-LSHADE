function g = transform(image, a, b, c, k)

global_mean = mean(image(:));
im_size = size(image);

g = zeros(im_size);
B = mean_n(image);
C = std_n(image,B);

x=C+b;
w=k.*global_mean;
K=w./x;
g=K.*(image-(c*B))+(B.^a);