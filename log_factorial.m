% --------------------log_facorial.m-----------------------------
% 计算n的阶乘的自然对数
% ------------------

function f = log_factorial(n)

f = 0;
for i = 1:n
   f = f + log(i); 
end

end