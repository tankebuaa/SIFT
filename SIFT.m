% -------------------------------------SIFT.m------------------------------
% Detect SIFT features.
%        Copyright By Tan Ke. 
% --------------------------------------------

clear all;
close all;
clc;
%% 参数设置
% 是否扩展原图
sift_img_dbl = 1;
% 初始高斯平滑参数
sift_sigma = 1.6;
% 初始图像高斯平滑
sift_init_sigma = 0.5;
% default number of sampled intervals per octave
sift_intvls = 3;
% default threshold on keypoint contrast |D(x)|
sift_contr_thr = 0.04;
% default threshold on keypoint ratio of principle curvatures
sift_curv_thr = 3;
% width of border in which to ignore keypoints
sift_img_border = 5;
% maximum steps of keypoint interpolation before failure
sift_max_interp_steps = 5;
% 特征点方向直方图柱数
sift_ori_hist_bins = 36;
% 特征点方向直方图加权1.5 * sigma
sift_ori_sig_fctr = 1.5;
% 特征点方向直方图赋值搜索领域半径3.0 * 1.5 * sigma
sift_ori_radius = 3.0 * sift_ori_sig_fctr;
% 特征点方向赋值过程中，梯度直方图的平滑次数
sift_ori_smooth_passes = 2;
% 特征点方向赋值过程中，梯度幅值达到最大值的80%则分裂为两个特征点
sift_ori_peak_ratio = 0.8;
% default width of descriptor histogram array
sift_descr_width = 4;
% default number of bins per histogram in descriptor array
sift_descr_hist_bins = 8;
% determines the size of a single descriptor orientation histogram
sift_descr_scl_fctr = 3.0;
% threshold on magnitude of elements of descriptor vector
sift_descr_mag_thr = 0.2;
% factor used to convert floating-point descriptor to unsigned char
sift_int_descr_fctr = 512.0;
%% process
% 读入图片
image = imread('scene.pgm');
img = double(image) / 255.0;

disp('detect sift features...');
% 获得初始图像
init_img = create_init_image(img, sift_img_dbl, sift_sigma, sift_init_sigma);

% 高斯金字塔数
sift_octvs = floor(log(min(size(init_img))) / log(2) - 2);

% 为了保证连续性，在每一层的顶层继续用高斯模糊生成3幅图像，所以高斯金字塔每组有intvls+3层，DOG金字塔每组有intvls+2层
% 建立高斯金字塔gauss_pyr，是一个octvs*(intvls+3)的元胞数组 
gauss_pyr = build_gauss_pyr(init_img, sift_octvs, sift_intvls, sift_sigma);

% 通过对高斯金字塔中每相邻两层图像相减来建立高斯差分金字塔
dog_pyr = build_dog_pyr(gauss_pyr, sift_octvs, sift_intvls);

%% 在尺度空间中检测极值点，并进行精确定位和筛选 
% 在尺度空间中检测极值点，通过插值精确定位，去除低对比度的点，去除边缘点，返回检测到的特征点序列
features = scale_space_exterm(dog_pyr, sift_octvs, sift_intvls, sift_contr_thr, sift_curv_thr, sift_img_border, sift_max_interp_steps);

% 计算特征点序列features中每个特征点的尺度,若设置了将图像放大为原图的2倍,将特征点序列中每个特征点的坐标减半
features = calc_feature_scales(features, sift_sigma, sift_intvls, sift_img_dbl);

%% 特征点方向赋值，完成此步骤后，每个特征点有三个信息：位置、尺度、方向
% 计算每个特征点的梯度直方图，找出其主方向，若一个特征点有不止一个主方向，将其分为两个特征点
[features, N] = calc_feature_oris( features, gauss_pyr, sift_ori_hist_bins, sift_ori_radius, sift_ori_sig_fctr, sift_ori_smooth_passes, sift_ori_peak_ratio);

disp(['Done! Get ', num2str(N), ' interesting points']);
%% 计算特征描述子
disp('Solve the descriptors and drawing ...');

% 计算特征点序列中每个特征点的特征描述子向量 
features = compute_descriptors( features, gauss_pyr, sift_descr_width, sift_descr_hist_bins, sift_descr_scl_fctr, sift_descr_mag_thr, sift_int_descr_fctr);

% sort features by decreasing scale and move from CvSeq to array
features = sort_scale(features);

%% 显示特征点
draw_lowe_feature(img, features);
