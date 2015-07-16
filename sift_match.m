% ---------------------sift_match.m----------------------------------
%
% --------------------

function [feat1, n1] = sift_match(img1, img2)
% the maximum number of keypoint NN candidates to check during BBF search
kdtree_bbf_max_nn_chks = 200;
% initial # of priority queue elements for which to allocate space 
minpq_init_nallocd = 512;
% threshold on squared ratio of distances between NN and 2nd NN 
NN_SQ_DIST_RATIO_THR = 0.49;

[feat1, n1] = sift_features(img1);
[feat2, n2] = sift_features(img2);
disp('Build KD-Tree...');
kd_root = kdtree_build(feat2, n2);

disp('search the kd-tree and match...');
n = 0;
for i = 1:n1
   nbrs = kdtree_bbf_knn(kd_root, feat1{i}, 2, kdtree_bbf_max_nn_chks, minpq_init_nallocd); 
   d0 = descr_dist_sq(feat1{i}, nbrs{1});
   d1 = descr_dist_sq(feat1{i}, nbrs{2});
   if d0 < d1 * NN_SQ_DIST_RATIO_THR
      n = n + 1;
      feat1{i}.fwd = 1;
      feat1{i}.fwd_match = nbrs{1};
   else
      feat1{i}.fwd = 0;
   end
end
disp(['Get ', num2str(n), ' matches without RANSAC!']);

end