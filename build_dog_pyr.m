% ------------------------- build_dog_pyr.m--------------------------------
% Builds a difference of Gaussians scale space pyramid by subtracting adjacent
% intervals of a Gaussian pyramid
% º∆À„DOG
% ----------

function [dog_pyr] = build_dog_pyr(gauss_pry, sift_octvs, sift_intvls)

dog_pyr = cell(sift_octvs, sift_intvls + 2);
for o = 1:sift_octvs
   for i = 1:sift_intvls + 2
      dog_pyr{o, i} =  gauss_pry{o, i+1} - gauss_pry{o, i};
   end
end
end