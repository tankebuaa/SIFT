% ------------------------expand_kd_node_subtree.m ------------------------
% Recursively expands a specified kd tree node into a tree whose leaves
%  contain one entry each.
% -------------------

function kd_node = expand_kd_node_subtree(kd_node)

if kd_node.n == 1 || kd_node.n == 0
   kd_node.leaf = 1;
   return
end
kd_node = assign_part_key(kd_node);
kd_node = partition_features(kd_node);
if kd_node.leaf == 0
    kd_node.kd_left = expand_kd_node_subtree(kd_node.kd_left);
end
if kd_node.leaf ==0
    kd_node.kd_right = expand_kd_node_subtree(kd_node.kd_right);
end

end