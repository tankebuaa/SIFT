% ----------------------------minpq_insert.m----------------------------
% Inserts an element into a minimizing priority queue.
% -----------------------

function min_pq = minpq_insert(min_pq, data, key)

n = min_pq.n;
min_pq.pq_array{n}.data = data;
min_pq.pq_array{n}.key = 2147483647;
min_pq = decrease_pq_node_key(min_pq, n, key);
min_pq.n = min_pq.n + 1;

end