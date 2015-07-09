% --------------------------partition_features.m---------------------------
% Partitions the features at a specified kd tree node to create its two
%  children.
% -------------------

function kd_node = partition_features(kd_node)

features = kd_node.features;
n = kd_node.n;
ki = kd_node.ki;
kv = kd_node.kv;
j = 0;
for i = 1:n
   if features{i}.descr(ki) <=kv
       j = j + 1;
       tmp = features{j};
       features{j} = features{i};
       features{i} = tmp;
       if features{j}.descr(ki) == kv
           p = j;
       end
   end
end
tmp = features{p};
features{p} = features{j};
features{j} = tmp;
% if all records fall on same side of partition, make node a leaf
if j == n
    kd_node.leaf = 1;
   % kd_node.bottom = 1;
    return
end
kd_node.kd_left = kd_node_init(features(1:j-1), j-1);
kd_node.kd_right = kd_node_init(features(j+1:n), n-j);

end