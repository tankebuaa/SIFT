% ------------------------interp_step.m------------------------------------
% Performs one step of extremum interpolation.
%  Based on Eqn. (3) in Lowe's paper.
% -------------

function [xi, xr, xc] = interp_step(dog_pyr, octv, intvl, r, c)

% 计算x,y,sigma方向的偏导数df/dx = (f(x+1, y, sig) - f(x-1, y, sig)) / 2.0
dD = [(dog_pyr{octv, intvl}(r, c+1) - dog_pyr{octv, intvl}(r, c)) / 2.0;
    (dog_pyr{octv, intvl}(r+1, c) - dog_pyr{octv, intvl}(r-1, c)) / 2.0;
    (dog_pyr{octv, intvl+1}(r, c) - dog_pyr{octv, intvl-1}(r, c)) / 2.0];
% 计算DOG金字塔中某个点的3*3的Hessian矩阵
v = dog_pyr{octv, intvl}(r, c);   
dxx = (dog_pyr{octv, intvl}(r, c+2) + dog_pyr{octv, intvl}(r, c-2) - 2 * v);
dyy = (dog_pyr{octv, intvl}(r+1, c) + dog_pyr{octv, intvl}(r-1, c) - 2 * v);
dss = (dog_pyr{octv, intvl+1}(r, c) + dog_pyr{octv, intvl-1}(r, c) - 2 * v);
dxy = (dog_pyr{octv, intvl}(r+1, c+1) - dog_pyr{octv, intvl}(r+1, c-1) - ...
    dog_pyr{octv, intvl}(r-1, c+1) + dog_pyr{octv, intvl}(r-1, c-1)) / 4.0;
dxs = (dog_pyr{octv, intvl+1}(r, c+1) - dog_pyr{octv, intvl+1}(r, c-1) - ...
    dog_pyr{octv, intvl-1}(r, c+1) + dog_pyr{octv, intvl-1}(r, c-1)) / 4.0;
dys = (dog_pyr{octv, intvl+1}(r+1, c) - dog_pyr{octv, intvl-1}(r+1, c) - ...
    dog_pyr{octv, intvl+1}(r-1, c) + dog_pyr{octv, intvl-1}(r-1, c)) / 4.0;
H = [dxx dxy dxs; dxy dyy dys; dxs dys dss];
% 算出x,y,sig方向上的偏移量
x = - pinv(H) * dD;
xi = x(3);
xr = x(2);
xc = x(1);
end