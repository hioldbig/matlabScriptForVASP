function zhubo(radius,points)
% ��ֱ������ϵ�еĶ�ά����ת��������ȥ
% ������һ��������פ�����������Ϊ����
% ����1Ϊ����뾶������2Ϊ��ͼ�ĵ���
  
  x=-2*radius*pi:pi/points:2*radius*pi;
  y=sin(x);
  
  r=radius;
  
  sita=x/r;
 
  x1=(y+radius).*sin(sita);
  y1=(y+radius).*cos(sita);
  
  x2=radius*sin(sita);
  y2=radius*cos(sita);
  
  plot(x1,y1)
  
  hold on
  
  plot(x2,y2,'r')
  axis equal
  hold off

end

