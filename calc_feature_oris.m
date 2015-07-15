% -----------------------------------calc_feature_oris.m-----------------------
%  Computes a canonical orientation for each image feature in an array.  Based
%  on Section 5 of Lowe's paper.  This function adds features to the array when
%  there is more than one dominant orientation at a given feature location.
% ----------------------------

function [features, sum] = calc_feature_oris(features, gauss_pyr, sift_ori_hist_bins, sift_ori_radius, sift_ori_sig_fctr, sift_ori_smooth_passes, sift_ori_peak_ratio)
% ���������������������
[N, ~] = size(features);
% ����
for i = 1:N
    % ����ָ�����ص���ݶȷ���ֱ��ͼ�����ش��ֱ��ͼ�������hist
   hist = ori_hist(gauss_pyr{features{i}.ddata.octv, features{i}.ddata.intvl}, ...
       features{i}.ddata.r, features{i}.ddata.c, sift_ori_hist_bins, ...
       round(sift_ori_radius * features{i}.ddata.scl_octv), ...
       sift_ori_sig_fctr * features{i}.ddata.scl_octv);
   % ��ֱ��ͼ���и�˹ƽ��,�ֲ���û�з��䲻���Զ������������㲻�ȶ�������,sift_ori_smooth_passesָ����ƽ������
   for j = 1:sift_ori_smooth_passes
      hist = smooth_ori_hist(hist, sift_ori_hist_bins); 
   end
   
   % �����ݶ�ֱ��ͼ����������ݶȷ�ֵ��������ֱ��ͼ�����bin��ֵ,���ظ�omax
   omax = max(hist);
   
   % ����ǰ�������ֱ��ͼ��ĳ��bin��ֵ���ڸ�������ֵ����������һ�������㲢��ӵ�����������ĩβ;
   % �����������ָ��feat���Ѿ�������������features���Ƴ��ģ����Լ�ʹ��������û�и�����(�ڶ������ڷ�ֵ��ֵ�ķ���),
   % �ں���add_good_ori_features��Ҳ��ִ��һ�ο�¡feat�����䷽����в�ֵ���������������������еĲ���
   % ��ֵ��ֵһ������Ϊ��ǰ��������ݶ�ֱ��ͼ�����binֵ��80%
   features = add_good_ori_features(features, hist, sift_ori_hist_bins, omax * sift_ori_peak_ratio, i);
   
end
[M, ~] = size(features);
   features = features(N+1:M);
[sum, ~] = size(features);
end