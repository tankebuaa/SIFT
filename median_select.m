% ------------------------median_select.m----------------------------------
% ���㳤��Ϊn������array����λ��
% --------------------

function med = median_select(arry, n)

if mod(n, 2) == 1
    med = median(arry);
else
    med = median(arry(1:n-1));
end

end