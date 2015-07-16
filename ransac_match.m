% ----------------------ransac_match.m--------------------------------------
%
% ---------------------------------

clear;
close all;
clc;

% RANSAC error tolerance in pixels
RANSAC_ERR_TOL = 3;
% pessimistic estimate of fraction of inlers for RANSAC
in_frac = 0.25;
% estimate of the probability that a correspondence supports a bad model
RANSAC_PROB_BAD_SUPP = 0.10;
% 计算转换矩阵的点数
m = 4;
% desired probability that the final transformation returned by RANSAC is corrupted by outliers (i.e. the probability that no samples of all inliers were drawn)
p_badxform = 0.01;
% correspondences within this distance of a computed model are considered as inliers
err_tol = 3.0;


img1 = imread('1.pgm');
img2 = imread('2.pgm');
[r1, c1] = size(img1);
[r2, c2] = size(img2);
img_stack = 255.0 * ones(max(r1,r2), c1+c2);
img_stack(1:r1, 1:c1) = img1(1:r1, 1:c1);
img_stack(1:r2, c1+1 : c1+c2) = img2(1:r2, 1:c2);
img_stack = img_stack / 255.0;
figure;
imshow(img_stack);
hold on;

% 第一幅图的特征点序列，其中包含相应第二幅的匹配点的坐标
[features, n] = sift_match(img1, img2);
disp('RANSAC...');

% 获得匹配特征点数组到matched
[matched, nm] = get_matched_features(features, n);

% 计算保证RANSAC最终计算出的转换矩阵错误的概率小于p_badxform所需的最小内点数目 
in_min= calc_min_inliers(nm, m, RANSAC_PROB_BAD_SUPP, p_badxform);

k = 0;
p = (1.0 - in_frac^m)^k;
in_max = 0;
%while p > p_badxform
while k < 500
   % Draws a RANSAC sample from a set of features.
   sample = draw_ransac_sample(matched, nm, m);
   [pts, mpts] = extract_corresp_pts(sample, m);
   M = homog(pts, mpts, m);
   [in, consensus] = find_consensus(matched, nm, M, err_tol);
   if in > in_max
      consensus_max = consensus;
      in_max = in;
      in_frac = in_max / m;
   end
   k = k + 1;
   p = (1.0 - in_frac^m)^k;
end

disp(['Done! Get ',num2str(in_max), ' matches. Drawing...']);
for i = 1:in_max
      start_x = consensus_max{i}.x;
      start_y = consensus_max{i}.y;
      end_x = consensus_max{i}.fwd_match.x + c1;
      end_y = consensus_max{i}.fwd_match.y;
      line([start_x end_x], [start_y end_y],'LineWidth',1,'Color',[0 1 0]);
      hold on;
end


