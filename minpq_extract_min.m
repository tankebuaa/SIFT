% -------------------------minpq_extract_min.m-----------------------------
% Removes and returns the element of a minimizing priority queue with the
%  smallest key.
% ----------------

function [expl, min_pq, flag] = minpq_extract_min(min_pq)

if min_pq.n < 2
    flag = 0;
    return
end

expl = min_pq.pq_array{1}.data;
min_pq.n = min_pq.n - 1;
min_pq.pq_array{1} = min_pq.pq_array{min_pq.n};
min_pq = restore_minpq_order(min_pq, 1, min_pq.n);
flag = 1;

end