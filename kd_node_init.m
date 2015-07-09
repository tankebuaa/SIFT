% --------------------kd_node_init.m---------------------------------------
% Initializes a kd tree node with a set of features.  The node is not
%  expanded, and no ordering is imposed on the features.
% ----------------------

function kd_node = kd_node_init(features, n)
kd_node.ki = 0;
kd_node.kv = 0;
kd_node.leaf = 0;
kd_node.features = features;
kd_node.n = n;
kd_node.kd_left = 0;
kd_node.kd_right = 0;
%kd_node.bottom = 0;
end