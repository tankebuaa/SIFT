% -----------------------kdtree_bbf_knn.m----------------------------------
% Finds an image feature's approximate k nearest neighbors in a kd tree using
%  Best Bin First search.
% ------------------------

function nbrs = kdtree_bbf_knn(kd_root, feat, k, max_nn_chks, MINPQ_INIT_NALLOCD)

t = 0;
n = 1;

nbrs = cell(k, 1);
min_pq.nallocd = MINPQ_INIT_NALLOCD;
min_pq.n = 1;
min_pq.pq_array = cell(MINPQ_INIT_NALLOCD, 1);

min_pq = minpq_insert(min_pq, kd_root, 0);

while min_pq.n > 1 && t < max_nn_chks
    [expl, min_pq] = minpq_extract_min(min_pq);
    [expl, min_pq] = explore_to_leaf(expl, feat, min_pq);
    for i = 1:expl.n
        bbf_data.old_data = expl.features{i}.ddata;
        bbf_data.d = descr_dist_sq(feat, expl.features{i});
        expl.features{i}.ddata = bbf_data;
        [nbrs, flag] = insert_into_nbr_array(expl.features{i}, nbrs, n, k);
        n = n + flag;
    end
    t = t + 1;
end

end