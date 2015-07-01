% ---------------------calc_grad_mag_ori.m---------------------------------
% Calculates the gradient magnitude and orientation at a given pixel.
% ---------------------

function [mag, ori, flag] = calc_grad_mag_ori(img, r, c)
[height, width] = size(img);
if r > 1 && r < height - 1 && c > 1 && c < width - 1
   dx = img(r, c+1) - img(r, c-1);
   dy = img(r-1, c) - img(r+1, c);
   mag = sqrt(dx * dx + dy * dy);
   ori = atan2(dy, dx);
   flag = 1;
else
    mag = 0;
    ori = 0;
    flag = 0;
end

end