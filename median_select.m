% ------------------------median_select.m----------------------------------
% 计算长度为n的数组array的中位数
% --------------------

function med = median_select(arry, n)

if mod(n, 2) == 1
    med = median(arry);
else
    med = median(arry(1:n-1));
end

end