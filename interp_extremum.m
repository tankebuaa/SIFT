% --------------------------------- interp_extremum.m --------------------
% Interpolates a scale-space extremum's location and scale to subpixel
% accuracy to form an image feature.  Rejects features with low contrast.
% Based on Section 4 of Lowe's paper.
% ------------------------------------

function [feat] = interp_extremum(dog_pyr, octv, intvl, r, c, sift_intvls, sift_contr_thr, sift_max_interp_steps, sift_img_border)
[rows, cols] = size(dog_pyr{octv, intvl});
i = 0;  % ��ֵ����
while i < sift_max_interp_steps
    [xi, xr, xc] = interp_step(dog_pyr, octv, intvl, r, c);
    if abs(xi) < 0.5 && abs(xr) < 0.5 && abs(xc) < 0.5
        break;
    end
    c = c + round(xc);      % x��������
    r = r + round(xr);      % y��������
    intvl = intvl + round(xi);  % sigma���򣬼��㷽������
    
    % �����������������Χ���������ֵ������NULL
    if intvl < 2 || intvl > sift_intvls+1 || r < sift_img_border || c < sift_img_border || r >= rows - sift_img_border || c >= cols - sift_img_border
        feat.flags = 0;
        return
    end
    
    i = i + 1;
end

% ����max_interp_steps�β�ֵ��û������������λ�ã������������ֵ��
if i > sift_max_interp_steps
    feat.flags = 0;
    return
end

% ���㱻��ֵ��ĶԱȶȣ�D + 0.5 * dD^T * X
contr = interp_contr(dog_pyr, octv, intvl, r, c, xi, xr, xc);
% ����õ�ĶԱȶȹ�С��������������0
if abs(contr) < sift_contr_thr / sift_intvls
    feat.flags = 0;
    return
end
feat.flags = 1;
feat.x = (c + xc) * 2 ^ octv;
feat.y = (r + xr) * 2 ^ octv;
img_pt.x = feat.x;
img_pt.y = feat.y;
feat.img_pt = img_pt;
ddata.r = r;
ddata.c = c;
ddata.octv = octv;
ddata.intvl = intvl;
ddata.subintvl = xi;
feat.ddata = ddata;
end