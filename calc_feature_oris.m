% -----------------------------------calc_feature_oris.m-----------------------
%  Computes a canonical orientation for each image feature in an array.  Based
%  on Section 5 of Lowe's paper.  This function adds features to the array when
%  there is more than one dominant orientation at a given feature location.
% ----------------------------

function [features, sum] = calc_feature_oris(features, gauss_pyr, sift_ori_hist_bins, sift_ori_radius, sift_ori_sig_fctr, sift_ori_smooth_passes, sift_ori_peak_ratio)
% 特征点序列中特征点个数
[N, ~] = size(features);
% 遍历
for i = 1:N
    % 计算指定像素点的梯度方向直方图，返回存放直方图的数组给hist
   hist = ori_hist(gauss_pyr{features{i}.ddata.octv, features{i}.ddata.intvl}, ...
       features{i}.ddata.r, features{i}.ddata.c, sift_ori_hist_bins, ...
       round(sift_ori_radius * features{i}.ddata.scl_octv), ...
       sift_ori_sig_fctr * features{i}.ddata.scl_octv);
   % 对直方图进行高斯平滑,弥补因没有仿射不变性而产生的特征点不稳定的问题,sift_ori_smooth_passes指定了平滑次数
   for j = 1:sift_ori_smooth_passes
      hist = smooth_ori_hist(hist, sift_ori_hist_bins); 
   end
   
   % 查找梯度直方图中主方向的梯度幅值，即查找直方图中最大bin的值,返回给omax
   omax = max(hist);
   
   % 若当前特征点的直方图中某个bin的值大于给定的阈值，则新生成一个特征点并添加到特征点序列末尾;
   % 传入的特征点指针feat是已经从特征点序列features中移除的，所以即使此特征点没有辅方向(第二个大于幅值阈值的方向),
   % 在函数add_good_ori_features中也会执行一次克隆feat，对其方向进行插值修正，并插入特征点序列的操作
   % 幅值阈值一般设置为当前特征点的梯度直方图的最大bin值的80%
   features = add_good_ori_features(features, hist, sift_ori_hist_bins, omax * sift_ori_peak_ratio, i);
   
end
[M, ~] = size(features);
   features = features(N+1:M);
[sum, ~] = size(features);
end