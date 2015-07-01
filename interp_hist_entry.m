% ----------------------------interp_hist_entry.m--------------------------
% Interpolates an entry into the array of orientation histograms that form
%  the feature descriptor.
% --------------------------

function hist = interp_hist_entry(hist, rbin, cbin, obin, mag, d, n)
r0 = floor(rbin);
c0 = floor(cbin);
o0 = floor(obin);
d_r = rbin - r0;
d_c = cbin - c0;
d_o = obin - o0;

for r = 0:1
   rb = r0 + r; 
    if rb >= 0 && rb < d
       if r == 0
           v_r = mag * (1.0 - d_r);
       else
           v_r = mag * d_r;
       end
       for c = 0:1
           cb = c0 + c;
           if cb >= 0 && cb < d
              if c == 0
                  v_c = v_r * (1.0 - d_c);
              else
                  v_c = v_r * d_c;
              end
              for o = 0:1
                 ob =  mod(o0 + o, n);
                 if o ==0
                     v_o = v_c * (1.0 - d_o);
                 else
                     v_o = v_c * d_o;
                 end
                 hist{rb+1, cb+1}(ob+1) = hist{rb+1, cb+1}(ob+1) + v_o;
              end
           end
       end
    end
end

end