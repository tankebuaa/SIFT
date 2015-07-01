% --------------------------create_init_image.m-----------------------------
% Converts an image to 8-bit grayscale and Gaussian-smooths it.  The image is
% optionally doubled in size prior to smoothing.
% ��ó�ʼͼ��
% -----------------------------------

function [init_img] = create_init_image(img, sift_img_dbl, sift_sigma, sift_init_sigma)
% ת��Ϊ�Ҷ�ͼ��
if ndims(img) == 3
    gray = rgb2gray(img);
else
    gray = img;
end
% �Ƿ�����Ϊԭ��������Ϊ��ʼͼ��
if sift_img_dbl
    sig_diff = sqrt(sift_sigma * sift_sigma - sift_init_sigma * sift_init_sigma * 4);
    dbl = imresize(gray, 2.0, 'cubic');
    % ��˹�˴�С����3*sigmaԭ�򣨺���Ҫ��
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