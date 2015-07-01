% ---------------------------build_gauss_pyr.m-----------------------------
% Builds Gaussian scale space pyramid from an image
% ������˹������
% --------------------

function [gauss_pyr] = build_gauss_pyr(base, sift_octvs, sift_intvls, sift_sigma)

% gauss_pry�Ƕ�άԪ�����飬ÿ��Ԫ����ͼ���
gauss_pyr = cell(sift_octvs, sift_intvls + 3);

% ����ÿ�θ�˹ģ����sigma����
sig = zeros(sift_intvls + 3, 1); 
sig(1) = sift_sigma;% ��ʼ�߶�
k = 2^(1 / sift_intvls);
for i = 2:sift_intvls + 3
   sig_prev = sift_sigma * k^(i-2);
   sig_total = sig_prev * k;
   sig(i) = sqrt(sig_total * sig_total - sig_prev * sig_prev);
end

% ����ÿһ��
for o = 1:sift_octvs
   for i = 1:sift_intvls + 3
      if o == 1 &&  i == 1
          % ��һ�����ĵ�һ��Ϊԭͼ��
          gauss_pyr{o, i} = base;
      elseif i == 1
          % ���������߶ȱ�Ϊһ��ceil(width$height/2),ÿ���һ������һ����ķ�����������Ϊs^3 =
          % 2,�������൱�ڰ�sigma���Զ�
          gauss_pyr{o, i} = imresize(gauss_pyr{o - 1, sift_intvls+1}, 0.5, 'nearest');
      else
          % ��ͬһ�߶Ƚ��������һ������һ��ĸ�˹�˲�
          core = round(3 * sig(i));
          h = fspecial('gaussian', [core core], sig(i));
          gauss_pyr{o, i} = imfilter(gauss_pyr{o, i - 1}, h);
      end
   end
end
end