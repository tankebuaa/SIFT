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
% ��һ������������������ӣ��������������������е�ÿ��Ԫ�س������������ӵ�ģ
feat.descr = feat.descr / norm(feat.descr);

% �������������ӣ�������sift_descr_mag_thr��Ԫ�أ�ǿ��Ϊsift_descr_mag_thr
for i = 1:k
   if feat.descr(i) > sift_descr_mag_thr
       feat.descr(i) = sift_descr_mag_thr;
   end
end
feat.descr = feat.descr / norm(feat.descr);

% �������������ӣ�ÿ��Ԫ�س���ϵ��sift_int_descr_fctr����Ϊ���Σ��������ֵ���ܳ���255
for i = 1:k
   int_val = sift_int_descr_fctr * feat.descr(i);
   feat.descr(i) = min(255, int_val);
end

end