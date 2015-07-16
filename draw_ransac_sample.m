% ----------------------------draw_ransac_sample.m-------------------------
% Draws a RANSAC sample from a set of features.
% ----------------------

function sample = draw_ransac_sample(features, n, m)
sample = cell(4,1);
for i = 1:n
    features{i}.sampled = 0;
end
for i = 1:m
    x = mod(randi(n, 1), n) + 1;
    while features{x}.sampled
        x = mod(randi(n, 1), n)+ 1;
    end
    sample{i} = features{x};
    features{x}.sampled = 1;
end

end