% ------------------------add_good_ori_features.m--------------------------
% Adds features to an array for every orientation in a histogram greater than
%  a specified threshold.
% --------------------------

function features = add_good_ori_features(features, hist, n, mag_thr, k)

PI2 = 2.0 * pi;
% ����ֱ��ͼ
for i = 1:n
   [N, ~] = size(features); 
   % ��ߵ��±�
   if i == 1
       l = n;
   else
       l = i - 1;
   end
   % �ұߵ��±�
   if i == n
       r = 1;
   else
       r = i + 1;
   end
   
   % ����ǰ��bin�Ǿֲ���ֵ����ǰһ���ͺ�һ��bin���󣩣�����ֵ���ڸ����ķ�����ֵ��������һ���µ������㲢��ӵ�����������ĩβ
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