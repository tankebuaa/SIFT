% ----------------------explore_to_leaf.m----------------------------------
% Explores a kd tree from a given node to a leaf.  Branching decisions are
%  made at each node based on the descriptor of a given feature.  Each node
% examined but not explored is put into a priority queue to be explored
% later, keyed based on the distance from its partition key value to the
% given feature's desctiptor.
% ----------------------------

function [expl, min_pq] = explore_to_leaf(expl, feat, min_pq)

while expl.leaf == 0
   ki = expl.ki;
   kv = expl.kv;
   if feat.descr(ki) <= kv
       unexpl = expl.kd_right;
       expl = expl.kd_left;
   else
       unexpl = expl.kd_left;
       expl = expl.kd_right;
   end
   min_pq = minpq_insert(min_pq, unexpl, abs(kv - feat.descr(ki)));
    
end

end