% --------------------------create_init_image.m-----------------------------
% Converts an image to 8-bit grayscale and Gaussian-smooths it.  The image is
% optionally doubled in size prior to smoothing.
% 获得初始图像
% -----------------------------------

function [init_img] = create_init_image(img, sift_img_dbl, sift_sigma, sift_init_sigma)
% 转化为灰度图像
if ndims(img) == 3
    gray = rgb2gray(img);
else
    gray = img;
end
% 是否扩大为原来两倍作为初始图像
if sift_img_dbl
    sig_diff = sqrt(sift_sigma * sift_sigma - sift_init_sigma * sift_init_sigma * 4);
    dbl = imresize(gray, 2.0, 'cubic');
    % 高斯核大小服从3*sigma原则（很重要）
    core = round(3 * sig_diff);
    h = fspecial('gaussian',[core core], sig_diff);
    init_img = imfilter(dbl, h);
else
    sig_diff = sqrt(sift_sigma * sift_sigma - sift_init_sigma * sift_init_sigma);
    core = round(3 * sig_diff);
    h = fspecial('gaussian',[core core], sig_diff);
    init_img = imfilter(gray, h);
end
end