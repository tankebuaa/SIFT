% -------------------------------------SIFT.m------------------------------
% Detect SIFT features.
%        Copyright By Tan Ke. 
% --------------------------------------------

clear all;
close all;
clc;
%% ��������
% �Ƿ���չԭͼ
sift_img_dbl = 1;
% ��ʼ��˹ƽ������
sift_sigma = 1.6;
% ��ʼͼ���˹ƽ��
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
% �����㷽��ֱ��ͼ����
sift_ori_hist_bins = 36;
% �����㷽��ֱ��ͼ��Ȩ1.5 * sigma
sift_ori_sig_fctr = 1.5;
% �����㷽��ֱ��ͼ��ֵ��������뾶3.0 * 1.5 * sigma
sift_ori_radius = 3.0 * sift_ori_sig_fctr;
% �����㷽��ֵ�����У��ݶ�ֱ��ͼ��ƽ������
sift_ori_smooth_passes = 2;
% �����㷽��ֵ�����У��ݶȷ�ֵ�ﵽ���ֵ��80%�����Ϊ����������
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
% ����ͼƬ
image = imread('scene.pgm');
img = double(image) / 255.0;

disp('detect sift features...');
% ��ó�ʼͼ��
init_img = create_init_image(img, sift_img_dbl, sift_sigma, sift_init_sigma);

% ��˹��������
sift_octvs = floor(log(min(size(init_img))) / log(2) - 2);

% Ϊ�˱�֤�����ԣ���ÿһ��Ķ�������ø�˹ģ������3��ͼ�����Ը�˹������ÿ����intvls+3�㣬DOG������ÿ����intvls+2��
% ������˹������gauss_pyr����һ��octvs*(intvls+3)��Ԫ������ 
gauss_pyr = build_gauss_pyr(init_img, sift_octvs, sift_intvls, sift_sigma);

% ͨ���Ը�˹��������ÿ��������ͼ�������������˹��ֽ�����
dog_pyr = build_dog_pyr(gauss_pyr, sift_octvs, sift_intvls);

%% �ڳ߶ȿռ��м�⼫ֵ�㣬�����о�ȷ��λ��ɸѡ 
% �ڳ߶ȿռ��м�⼫ֵ�㣬ͨ����ֵ��ȷ��λ��ȥ���ͶԱȶȵĵ㣬ȥ����Ե�㣬���ؼ�⵽������������
features = scale_space_exterm(dog_pyr, sift_octvs, sift_intvls, sift_contr_thr, sift_curv_thr, sift_img_border, sift_max_interp_steps);

% ��������������features��ÿ��������ĳ߶�,�������˽�ͼ��Ŵ�Ϊԭͼ��2��,��������������ÿ����������������
features = calc_feature_scales(features, sift_sigma, sift_intvls, sift_img_dbl);

%% �����㷽��ֵ����ɴ˲����ÿ����������������Ϣ��λ�á��߶ȡ�����
% ����ÿ����������ݶ�ֱ��ͼ���ҳ�����������һ���������в�ֹһ�������򣬽����Ϊ����������
[features, N] = calc_feature_oris( features, gauss_pyr, sift_ori_hist_bins, sift_ori_radius, sift_ori_sig_fctr, sift_ori_smooth_passes, sift_ori_peak_ratio);

disp(['Done! Get ', num2str(N), ' interesting points']);
%% ��������������
disp('Solve the descriptors and drawing ...');

% ����������������ÿ����������������������� 
features = compute_descriptors( features, gauss_pyr, sift_descr_width, sift_descr_hist_bins, sift_descr_scl_fctr, sift_descr_mag_thr, sift_int_descr_fctr);

% sort features by decreasing scale and move from CvSeq to array
features = sort_scale(features);

%% ��ʾ������
draw_lowe_feature(img, features);
