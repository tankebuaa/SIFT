% ---------------------------build_gauss_pyr.m-----------------------------
% Builds Gaussian scale space pyramid from an image
% 建立高斯金字塔
% --------------------

function [gauss_pyr] = build_gauss_pyr(base, sift_octvs, sift_intvls, sift_sigma)

% gauss_pry是二维元胞数组，每个元胞是图像层
gauss_pyr = cell(sift_octvs, sift_intvls + 3);

% 计算每次高斯模糊的sigma参数
sig = zeros(sift_intvls + 3, 1); 
sig(1) = sift_sigma;% 初始尺度
k = 2^(1 / sift_intvls);
for i = 2:sift_intvls + 3
   sig_prev = sift_sigma * k^(i-2);
   sig_total = sig_prev * k;
   sig(i) = sqrt(sig_total * sig_total - sig_prev * sig_prev);
end

% 遍历每一层
for o = 1:sift_octvs
   for i = 1:sift_intvls + 3
      if o == 1 &&  i == 1
          % 第一个塔的第一层为原图像
          gauss_pyr{o, i} = base;
      elseif i == 1
          % 降采样，尺度变为一半ceil(width$height/2),每组第一幅由上一组第四幅降采样，因为s^3 =
          % 2,降采样相当于把sigma除以二
          gauss_pyr{o, i} = imresize(gauss_pyr{o - 1, sift_intvls+1}, 0.5, 'nearest');
      else
          % 在同一尺度金字塔里，下一层是上一层的高斯滤波
          core = round(3 * sig(i));
          h = fspecial('gaussian', [core core], sig(i));
          gauss_pyr{o, i} = imfilter(gauss_pyr{o, i - 1}, h);
      end
   end
end
end