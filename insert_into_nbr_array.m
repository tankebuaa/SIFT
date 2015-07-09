% -----------------------------insert_into_nbr_array.m---------------------
% Inserts a feature into the nearest-neighbor array so that the array remains
%  in order of increasing descriptor distance from the search feature.
% -----------------

function [nbrs, flag] = insert_into_nbr_array(feat, nbrs, n, k)
flag = 0;
if n == 1
   nbrs{1} = feat;
   flag = 1;
   return
end
% check at end of arrary
df = feat.ddata.d;
dn = nbrs{n - 1}.ddata.d;
if df >= dn
   if n == k + 1
       feat.ddata = feat.ddata.old_data;
       flag = 0;
       return
   end
   nbrs{n} = feat;
   flag = 1;
   return
end

if n < k+1
    nbrs{n} = nbrs{n-1};
    flag = 1;
else
    nbrs{n-1}.ddata = nbrs{n-1}.ddata.old_data;
end

i = n - 2;
while i >=1
    dn = nbrs{i}.ddata.d;
    if dn <= df
        break;
    end
    nbrs{i+1} = nbrs{i};
    i = i - 1;
end
nbrs{i+1} = feat;

end
