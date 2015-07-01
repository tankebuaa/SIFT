% ---------------------------sort_scale.m----------------------------------
% sort features by decreasing scale and move from CvSeq to array
% ------------------------------

function features = sort_scale(features)
[k, ~] = size(features);
for i = 1:k-2
    for j = 1:k-i
        if features{j}.scl < features{j+1}.scl
            feat = features{j+1};
            features{j+1} = features{j};
            features{j} = feat;
        end
    end
end
for i = 1:k
   features{i} = rmfield(features{i}, 'ddata');
end
end