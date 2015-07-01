%---------------------------------is_extremum.m----------------------------
%  Determines whether a pixel is a scale-space extremum by comparing it to 
%  it's 3x3x3 pixel neighborhood.
% 判断是否是极值点
% ---------------------

function [bool] = is_extremum(dog_pyr, octv, intvl, r, c)
val = dog_pyr{octv, intvl}(r, c);
% check for maximun
if val > 0
    for i = -1:1
       for j = -1:1
          for k = -1:1
             if val < dog_pyr{octv, intvl + i}(r + j, c + k)
                 bool = 0;
                 return
             end
          end
       end
    end
    
% check for minimum
else
    for i = -1:1
       for j = -1:1
          for k = -1:1
             if val > dog_pyr{octv, intvl + i}(r + j, c + k)
                 bool = 0;
                 return
             end
          end
       end
    end
end

bool = 1;
end