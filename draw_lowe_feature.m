% ------------------draw_lowe_feature.m------------------------------------
% 
% ------------------------

function draw_lowe_feature(img, features)

[k, ~] = size(features);
scale = 5.0;
hscale = 0.75;
figure(1);
imshow(img);
hold on;
for i = 1:k
   feat = features{i};
   start_x = round(feat.x);
   start_y = round(feat.y);
   scl = feat.scl;
   ori = feat.ori;
   len = round(scl * scale);
   hlen = round(scl * hscale);
   blen = len - hlen;
   % 箭头杆的终点坐标
   end_x = round(len * cos(ori)) + start_x;
   end_y = round(len * -sin(ori)) + start_y;
   % 箭头的有分叉起点坐标
   h1_x = round(blen * cos(ori + pi/18.0)) + start_x;
   h1_y = round(blen * -sin(ori + pi/18.0)) + start_y;
   % 箭头的左分叉起点坐标
   h2_x = round(blen * cos(ori - pi/18.0)) + start_x;
   h2_y = round(blen * -sin(ori - pi/18.0)) + start_y;
   % 划线
   line([start_x end_x], [start_y end_y], 'LineWidth',1,'Color',[1 1 1]);
   line([h1_x end_x], [h1_y end_y], 'LineWidth',1,'Color',[1 1 1]);
   line([h2_x end_x], [h2_y end_y], 'LineWidth',1,'Color',[1 1 1]);

end


end