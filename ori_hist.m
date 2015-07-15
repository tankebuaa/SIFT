% --------------------ori_hist.m--------------------------------------
% Computes a gradient orientation histogram at a specified pixel.
%   Returns an n-element array containing an orientation histogram
%   representing orientations between 0 and 2 PI.
%----------------------

function hist = ori_hist(img, r, c, n, rad, sigma)
PI2 = 2.0 * pi;
exp_denom = 2.0 * sigma * sigma;
hist = zeros(n, 1);
for i = -rad:rad
   for j = -rad:rad
      [mag, ori, flag] = calc_grad_mag_ori(img, r + i, c + j);
      if flag
          w = exp(-(i*i + j*j) / exp_denom);
          bin = ceil(n * (ori + pi) / PI2);
          if bin > n
              bin = 1;
          elseif bin <1
              bin = n;
          end
          hist(bin) = hist(bin) + w * mag;
      end
   end
end



end