% ------------------draw_lowe_feature.m------------------------------------
% 
% ------------------------

function draw_lowe_feature(img, features)

[N, ~] = size(features);
scale = 5.0;
hscale = 0.75;
figure(1);
imshow(img);
hold on;
for i = 1:N
   feat = features{i};
   start_x = round(feat.x);
   start_y = round(feat.y);
   scl = feat.scl;
   ori = feat.ori;
   len = round(scl * scale)/ 5.0;
   hlen = round(scl * hscale)/5.0;
   blen = len - hlen;
   % ��ͷ�˵��յ�����
   end_x = round(len * cos(ori)) + start_x;
   end_y = round(len * -sin(ori)) + start_y;
   % ��ͷ���зֲ��������
   h1_x = round(blen * cos(ori + pi/18.0)) + start_x;
   h1_y = round(blen * -sin(ori + pi/18.0)) + start_y;
   % ��ͷ����ֲ��������
   h2_x = round(blen * cos(ori - pi/18.0)) + start_x;
   h2_y = round(blen * -sin(ori - pi/18.0)) + start_y;
   % ����
   line([start_x end_x], [start_y end_y], 'LineWidth',1,'Color',[0 1 0]);
   line([h1_x end_x], [h1_y end_y], 'LineWidth',1,'Color',[0 1 0]);
   line([h2_x end_x], [h2_y end_y], 'LineWidth',1,'Color',[0 1 0]);

end


end