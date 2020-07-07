function zhubo(radius,points)
% 将直角坐标系中的二维曲线转到球面上去
% 常见的一个例子是驻波，因此以其为名。
% 参数1为球面半径，参数2为绘图的点数
  
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

