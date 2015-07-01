% -------------------------smooth_ori_hist.m-------------------------------
% Gaussian smooths an orientation histogram.
% 
% -------------------------------

function hist = smooth_ori_hist(hist, n)

prev = hist(n);
for i = 1:n-1
   tmp = hist(i);
   hist(i) = 0.25 * prev + 0.5 * hist(i) + 0.25 * hist(i+1);
   prev = tmp;
end
hist(n) = 0.25 * hist(n-1) + 0.5 * hist(n) + 0.25 * hist(1);

end