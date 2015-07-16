% -----------------------calc_min_inliersm---------------------------------
%  计算保证RANSAC最终计算出的转换矩阵错误的概率小于p_badxform所需的最小内点数目
% Based on equation (7) in 
% Chum, O. and Matas, J.  Matching with PROSAC -- Progressive Sample Consensus.
% In <EM>Conference on Computer Vision and Pattern Recognition (CVPR)</EM>,
% (2005), pp. 220--226.
% -------------------------

function j = calc_min_inliers(n, m, p_badsupp, p_badxform)
for j = m+1:n
    sum = 0;
    for i = j:n
        pi = (i - m) * log(p_badsupp) + (n - i + m) * log(1.0 - p_badsupp) + ...
        log_factorial(n - m) - log_factorial( - m)- log_factorial(n - i);
    sum = sum + exp(pi);
    end
    if sum < p_badxform
        break;
    end
end
end