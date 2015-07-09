% ------------------------descr_dist_sq.m----------------------------------
% Calculates the squared Euclidian distance between two feature descriptors.
% --------------------

function dsq = descr_dist_sq(f1, f2)

dsq = norm(f1.descr - f2.descr);

end