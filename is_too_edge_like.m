% --------------------------is_too_edge_like.m-----------------------------
% Determines whether a feature is too edge like to be stable by computing the
%  ratio of principal curvatures at that feature.  Based on Section 4.1 of
%  Lowe's paper.
% --------------------------

function bool = is_too_edge_like(dog_img, r, c, curv_thr)
bool = 0;
d = dog_img(r, c);
dxx = dog_img(r, c+1) + dog_img(r, c-1) - 2 * d;
dyy = dog_img(r+1, c) + dog_img(r-1, c) - 2 * d;
dxy = (dog_img(r+1, c+1) + dog_img(r-1, c-1) - dog_img(r-1, c+1) - dog_img(r+1, c-1)) / 4.0;
tr = dxx + dyy;
det = dxx * dyy - dxy * dxy;
if det <=0
    bool = 0;
    return
end
if tr * tr / det < (curv_thr + 1.0 ) * (curv_thr + 1.0) / curv_thr
    bool  = 1;
    return
end

end