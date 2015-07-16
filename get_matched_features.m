% --------------------------get_matched_features.m-------------------------
% 
% --------------------------------

function [matched, nm] = get_matched_features(features, n)

matched_ = cell(n, 1);
m = 0;
for i = 1:n
   if features{i}.fwd == 1
       m = m + 1;
       matched_{m} = features{i};
   end
end
nm = m;
matched = matched_(1:nm);
end