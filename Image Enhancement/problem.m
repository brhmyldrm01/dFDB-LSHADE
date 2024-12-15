function [ fitness ] = problem(p, x)

im_size = cell2mat(p(4));
g = zeros(cell2mat(p(4)));
ik = cell2mat(p(3)) + x(2);
w= x(4).* cell2mat(p(1));
K=w./ik;
g=K.*(cell2mat(p(5))-(x(3)* cell2mat(p(2))))+(cell2mat(p(2)).^x(1));

image = g;
entropy_image = entropy (image);
a = edge(image,'sobel');
h_s = im_size(1);
v_s = im_size(2);
edge_pix = sum(sum(a));
enh = sobel_enh_conv(image);
edge_intensity = sum(enh(:));


fitness = (log(log(edge_intensity)))* (edge_pix* (exp(entropy_image)))/(h_s*v_s);








