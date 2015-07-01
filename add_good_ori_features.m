% ------------------------add_good_ori_features.m--------------------------
% Adds features to an array for every orientation in a histogram greater than
%  a specified threshold.
% --------------------------

function features = add_good_ori_features(features, hist, n, mag_thr, k)

PI2 = 2.0 * pi;
% 遍历直方图
for i = 1:n
   [N, ~] = size(features); 
   % 左边的下标
   if i == 1
       l = n;
   else
       l = i - 1;
   end
   % 右边的下标
   if i == n
       r = 1;
   else
       r = i + 1;
   end
   
   % 若当前的bin是局部极值（比前一个和后一个bin都大），并且值大于给定的幅度阈值，则生成一个新的特征点并添加到特征点序列末尾
   if hist(i) > hist(l) && hist(i) > hist(r) && hist(i) >= mag_thr
       bin = i + 0.5 * (hist(l)-hist(r)) / (hist(l) - 2.0*hist(i) + hist(r));
       if bin < 0
           bin = n + bin;
       elseif bin > n
           bin = bin - n;
       end
       new_feat = features{k};
       new_feat.ori = (PI2 * bin / n) - pi;
       features{N+1} = new_feat;
   end
end

end