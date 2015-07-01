% ---------------------------------compute_descriptors.m---------------------
% Computes feature descriptors for features in an array.  Based on Section 6
%  of Lowe's paper.
% --------------------

function features = compute_descriptors( features, gauss_pyr, d, n, sift_descr_scl_fctr, sift_descr_mag_thr, sift_int_descr_fctr)

[k, ~] = size(features);
for i = 1:k
    hist = descr_hist(gauss_pyr{features{i}.ddata.octv, features{i}.ddata.intvl}, ...
        features{i}.ddata.r, features{i}.ddata.c, features{i}.ori, ...
        features{i}.ddata.scl_octv, d, n, sift_descr_scl_fctr);
    features{i} = hist_to_descr(hist, d, n, features{i}, sift_descr_mag_thr, sift_int_descr_fctr);
end

end