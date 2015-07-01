% --------------------------scale_space_exterm.m--------------------------
% Detects features at extrema in DoG scale space.  Bad features are 
% discarded based on contrast and ratio of principal curvatures.
% 计算特征点序列
% ---------------

function [features] = scale_space_exterm(dog_pyr, sift_octvs, sift_intvls, sift_contr_thr, sift_curv_thr, sift_img_border, sift_max_interp_steps)
features_ = cell(10^5, 1);
% 像素的对比度阈值
prelim_contr_thr = 0.5 * sift_contr_thr / sift_intvls;

% 遍历高斯差分金字塔，检测极值点
% 忽略边界
mount = 0;
for o = 1:sift_octvs
   for i = 2:sift_intvls+1
      [m, n] = size(dog_pyr{o, 1});
      for r = sift_img_border + 1:m - sift_img_border
          for c = sift_img_border + 1:n - sift_img_border
              %进行初步的对比度检查，只有当归一化后的像素值大于对比度阈值prelim_contr_thr时才继续检测此像素点是否可能是极值
              if abs(dog_pyr{o, i}(r, c)) > prelim_contr_thr
                  
                 % //通过在尺度空间中将一个像素点的值与其周围3*3*3邻域内的点比较来决定此点是否极值点(极大值或极小都行)
                 if is_extremum(dog_pyr, o, i, r, c)
                    % 由于极值点的检测是在离散空间中进行的，所以检测到的极值点并不一定是真正意义上的极值点
                    % 因为真正的极值点可能位于两个像素之间，而在离散空间中只能精确到坐标点精度上
                    % 通过亚像素级插值进行极值点精确定位(修正极值点坐标)，并去除低对比度的极值点，将修正后的特征点组成feature结构返回
                    feat = interp_extremum(dog_pyr, o, i, r, c, sift_intvls, sift_contr_thr, sift_max_interp_steps, sift_img_border);
                    if feat.flags
                        ddata = feat.ddata;
                        % 去除边缘响应，即通过计算主曲率比值判断某点是否是边缘点，返回0则表示不是边缘点，可做特征点
                        if ~is_too_edge_like(dog_pyr{ddata.octv, ddata.intvl}, ddata.r, ddata.c, sift_curv_thr)
                            mount = mount + 1;
                            features_{mount} = rmfield(feat, 'flags');
                        end
                    end
                 end
              end
          end
      end
   end
end
features = features_(1:mount);
end