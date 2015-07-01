% ----------------------------hist_to_descr.m-------------------------------
% Converts the 2D array of orientation histograms into a feature's descriptor
%  vector.
% -------------------

function feat = hist_to_descr(hist, d, n, feat, sift_descr_mag_thr, sift_int_descr_fctr)
feat.descr = zeros(d * d * n, 1);
k = 0;
for r = 1:d
   for c = 1:d
      for o = 1:n
         k = k + 1;
         feat.descr(k) = hist{r, c}(o);
      end
   end
end

feat.d = k;
% 归一化特征点的特征描述子，即将特征描述子数组中的每个元素除以特征描述子的模
feat.descr = feat.descr / norm(feat.descr);

% 遍历特征描述子，将超过sift_descr_mag_thr的元素，强制为sift_descr_mag_thr
for i = 1:k
   if feat.descr(i) > sift_descr_mag_thr
       feat.descr(i) = sift_descr_mag_thr;
   end
end
feat.descr = feat.descr / norm(feat.descr);

% 遍历特征描述子，每个元素乘以系数sift_int_descr_fctr来变为整形，并且最大值不能超过255
for i = 1:k
   int_val = sift_int_descr_fctr * feat.descr(i);
   feat.descr(i) = min(255, int_val);
end

end