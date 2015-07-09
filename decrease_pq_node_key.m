% -------------------------decrease_pq_node_key.m--------------------------
% Decrease a minimizing pq element's key, rearranging the pq if necessary
% --------------

function min_pq = decrease_pq_node_key(min_pq, i, key)

if(key > min_pq.pq_array{i}.key)
    return;
end

min_pq.pq_array{i}.key = key;
while i > 1 && min_pq.pq_array{i}.key < min_pq.pq_array{round((i - 1) / 2)}.key
    tmp = min_pq.pq_array{round((i - 1) / 2)};
    min_pq.pq_array{round((i - 1) / 2)} = min_pq.pq_array{i};
    min_pq.pq_array{i} = tmp;
    i = round((i - 1) / 2);
end
end