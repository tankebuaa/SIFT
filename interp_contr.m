% ------------------------------interp_contr.m-----------------------------
% Calculates interpolated pixel contrast.  Based on Eqn. (3) in Lowe's
% paper.
% -------------------------

function [contr] = interp_contr(dog_pyr, octv, intvl, r, c, xi, xr, xc)

% 计算x,y,sigma方向的偏导数df/dx = (f(x+1, y, sig) - f(x-1, y, sig)) / 2.0
dD = [(dog_pyr{octv, intvl}(r, c+1) - dog_pyr{octv, intvl}(r, c-1)) / 2.0;
    (dog_pyr{octv, intvl}(r+1, c) - dog_pyr{octv, intvl}(r-1, c)) / 2.0;
    (dog_pyr{octv, intvl+1}(r, c) - dog_pyr{octv, intvl-1}(r, c)) / 2.0];
X = [xc xr xi];
% 计算被插值点的对比度：D + 0.5 * dD^T * X
contr = dog_pyr{octv, intvl}(r, c) + 0.5 * dD' * X';
end