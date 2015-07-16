% ----------------------extract_corresp_pts.m----------------------------
% 
% --------------------

function [pts, mpts] = extract_corresp_pts(sample, m)

pts = zeros(m,2);
mpts = zeros(m, 2);
for i = 1:m
   pts(i, 1) = sample{i}.y;
   pts(i, 2) = sample{i}.x;
   mpts(i, 1) = sample{i}.fwd_match.y;
   mpts(i, 2) = sample{i}.fwd_match.x;
end

end