% ------------------------------match.m-------------------------------------
% 
% --------------------
close all;
clear all;
clc;

% the maximum number of keypoint NN candidates to check during BBF search
kdtree_bbf_max_nn_chks = 200;
% initial # of priority queue elements for which to allocate space 
minpq_init_nallocd = 512;
% threshold on squared ratio of distances between NN and 2nd NN 
NN_SQ_DIST_RATIO_THR = 0.59;


img1 = imread('scene.pgm');
img2 = imread('basmati.pgm');
[r1, c1] = size(img1);
[r2, c2] = size(img2);
img_stack = 255.0 * ones(max(r1,r2), c1+c2);
img_stack(1:r1, 1:c1) = img1(1:r1, 1:c1);
img_stack(1:r2, c1+1 : c1+c2) = img2(1:r2, 1:c2);
img_stack = img_stack / 255.0;
figure;
imshow(img_stack);
hold on;

[feat1, n1] = sift_features(img1);
[feat2, n2] = sift_features(img2);

kd_root = kdtree_build(feat2, n2);
n = 0;
for i = 1:n1
   nbrs = kdtree_bbf_knn(kd_root, feat1{i}, 2, kdtree_bbf_max_nn_chks, minpq_init_nallocd); 
   d0 = descr_dist_sq(feat1{i}, nbrs{1});
   d1 = descr_dist_sq(feat1{i}, nbrs{2});
   if d0 < d1 * NN_SQ_DIST_RATIO_THR
      n = n + 1;
      start_x = feat1{i}.x;
      start_y = feat1{i}.y;
      end_x = nbrs{1}.x + c1;
      end_y = nbrs{1}.y;
      line([start_x end_x], [start_y end_y],'LineWidth',1,'Color',[1 1 1]);
      hold on;
   end
end
disp(['Get ', num2str(n), ' matches']);