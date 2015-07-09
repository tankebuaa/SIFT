% ------------------------restore_minpq_order.m----------------------------
% Recursively restores correct priority queue order to a minimizing pq array
% ----------------------------

function min_pq = restore_minpq_order(min_pq, i, n)
min = i;
l = 2 * i;
r = 2 * i + 1;
if l < n
   if min_pq.pq_array{l}.key < min_pq.pq_array{i}.key
       min = l;
   end
end
if r < n
   if min_pq.pq_array{r}.key < min_pq.pq_array{min}.key
       min = r;
   end
end

if min ~= i
   tmp = min_pq.pq_array{min};
   min_pq.pq_array{min} = min_pq.pq_array{i};
   min_pq.pq_array{i} = tmp;
   min_pq = restore_minpq_order(min_pq, min, n);
end

end