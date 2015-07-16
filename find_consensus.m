% --------------------------find_consensus.m-------------------------------
% 
% --------------------

function [in, consensus] = find_consensus(matched, nm, M, err_tol)

in = 0;
consensus_ = cell(nm, 1);
[pts, mpts] = extract_corresp_pts(matched, nm);
for i = 1:nm
    p1 = [pts(i,1);pts(i,2);1.0];
    p2 = [mpts(i,1);mpts(i,2);1.0];
    err = norm(p2 - M * p1);
    if err < err_tol
        in = in + 1;
        consensus_(in) = matched(i);
    end
    
end
consensus = consensus_(1:in);
end