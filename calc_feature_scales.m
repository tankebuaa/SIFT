% -----------------------------------calc_feature_scales-------------------
% Calculates characteristic scale for each feature in an array.
%
%--------------------------------


function features = calc_feature_scales(features, sift_sigma, sift_intvls, sift_img_dbl)
% 特征点序列中的点数
[M, ~] = size(features);
% 遍历
for i = 1:M
   intvl = features{i}.ddata.intvl + features{i}.ddata.subintvl;
   features{i}.scl = sift_sigma * 2^(features{i}.ddata.octv + intvl);
   features{i}.ddata.scl_octv = sift_sigma * 2^(intvl/sift_intvls);
   if sift_img_dbl
       features{i}.x = features{i}.x / 2.0;
       features{i}.y = features{i}.y / 2.0;
       features{i}.scl = features{i}.scl / 2.0;
       features{i}.img_pt.x = features{i}.img_pt.x / 2.0;
       features{i}.img_pt.y = features{i}.img_pt.y / 2.0;
   end
end

end