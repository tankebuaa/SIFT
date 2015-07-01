% --------------------------scale_space_exterm.m--------------------------
% Detects features at extrema in DoG scale space.  Bad features are 
% discarded based on contrast and ratio of principal curvatures.
% ��������������
% ---------------

function [features] = scale_space_exterm(dog_pyr, sift_octvs, sift_intvls, sift_contr_thr, sift_curv_thr, sift_img_border, sift_max_interp_steps)
features_ = cell(10^5, 1);
% ���صĶԱȶ���ֵ
prelim_contr_thr = 0.5 * sift_contr_thr / sift_intvls;

% ������˹��ֽ���������⼫ֵ��
% ���Ա߽�
mount = 0;
for o = 1:sift_octvs
   for i = 2:sift_intvls+1
      [m, n] = size(dog_pyr{o, 1});
      for r = sift_img_border + 1:m - sift_img_border
          for c = sift_img_border + 1:n - sift_img_border
              %���г����ĶԱȶȼ�飬ֻ�е���һ���������ֵ���ڶԱȶ���ֵprelim_contr_thrʱ�ż����������ص��Ƿ�����Ǽ�ֵ
              if abs(dog_pyr{o, i}(r, c)) > prelim_contr_thr
                  
                 % //ͨ���ڳ߶ȿռ��н�һ�����ص��ֵ������Χ3*3*3�����ڵĵ�Ƚ��������˵��Ƿ�ֵ��(����ֵ��С����)
                 if is_extremum(dog_pyr, o, i, r, c)
                    % ���ڼ�ֵ��ļ��������ɢ�ռ��н��еģ����Լ�⵽�ļ�ֵ�㲢��һ�������������ϵļ�ֵ��
                    % ��Ϊ�����ļ�ֵ�����λ����������֮�䣬������ɢ�ռ���ֻ�ܾ�ȷ������㾫����
                    % ͨ�������ؼ���ֵ���м�ֵ�㾫ȷ��λ(������ֵ������)����ȥ���ͶԱȶȵļ�ֵ�㣬������������������feature�ṹ����
                    feat = interp_extremum(dog_pyr, o, i, r, c, sift_intvls, sift_contr_thr, sift_max_interp_steps, sift_img_border);
                    if feat.flags
                        ddata = feat.ddata;
                        % ȥ����Ե��Ӧ����ͨ�����������ʱ�ֵ�ж�ĳ���Ƿ��Ǳ�Ե�㣬����0���ʾ���Ǳ�Ե�㣬����������
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