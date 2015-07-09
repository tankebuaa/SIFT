% -----------------------assign_part_key.m---------------------------------
% Determines the descriptor index at which and the value with which to
%  partition a kd tree node's features.
% -------------------------------

function kd_node = assign_part_key(kd_node)

features = kd_node.features;
n = kd_node.n;
d = features{1}.d;
var_max = 0;

% partition key index is that along which descriptors have most variance
for j = 1:d
    mean = 0;
    var = 0;
   for i = 1:n
       mean = mean + features{i}.descr(j);
   end
   mean = mean / n;
   for i = 1:n
      x = features{i}.descr(j) - mean;
      var = var + x * x;
   end
   var = var / n;
   if var >= var_max
      ki = j;
      var_max = var;
   end
end
% partition key value is median of descriptor values at ki
tmp = zeros(n, 1);
for i = 1:n
    tmp(i) = features{i}.descr(ki);
end
kv = median_select(tmp, n);
kd_node.ki = ki;
kd_node.kv = kv;
end