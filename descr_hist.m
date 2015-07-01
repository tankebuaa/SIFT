% -----------------------descr_hist.m--------------------------------------
% Computes the 2D array of orientation histograms that form the feature
%  descriptor.  Based on Section 6.1 of Lowe's paper.
% -------------------------------

function hist = descr_hist(img, r, c, ori, scl, d, n, sift_descr_scl_fctr)

PI2 = 2.0 * pi;
hist = cell(d, d);
for i = 1:d
   for j = 1:d
      hist{i,j} = zeros(n, 1); 
   end
end
cos_t = cos(ori);
sin_t = sin(ori);
bins_per_rad = n / PI2;
exp_denom = d * d * 0.5;
hist_width = sift_descr_scl_fctr * scl;
% 考虑到进行双线性插值，每个区域的宽度为：sift_descr_scl_fctr * scl * (d + 1.0)
% 再考虑到旋转因素，每个区域的宽度为： sift_descr_scl_fctr * scl * (d + 1.0) * sqrt(2)
% 搜索半径为：sift_descr_scl_fctr * scl * (d + 1.0) * sqrt(2) / 2
radius = floor(hist_width * sqrt(2) * (d + 1.0) * 0.5 + 0.5);

% 遍历每个区域的元素
for i = -radius:radius
   for j = -radius:radius
       c_rot = (j * cos_t - i * sin_t) / hist_width;
       r_rot = (j * sin_t + i * cos_t) / hist_width;
       rbin = r_rot + d / 2 - 0.5;
       cbin = c_rot + d / 2 - 0.5;
       
       if rbin > -1.0 && rbin < d && cbin > -1.0 && cbin < d
          [grad_mag, grad_ori, flag] = calc_grad_mag_ori(img, r+i, c+j);
          if flag
             grad_ori = grad_ori - ori;
             while grad_ori < 0.0
                 grad_ori = grad_ori + PI2;
             end
             while grad_ori >= PI2
                grad_ori = grad_ori - PI2; 
             end
             
             obin = grad_ori * bins_per_rad;
             w = exp(-(c_rot * c_rot + r_rot * r_rot) / exp_denom);
             hist = interp_hist_entry(hist, rbin, cbin, obin, grad_mag*w, d, n);
          end
       end
   end
end

end