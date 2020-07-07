function data= zhuiMian( pos,radius )
%  将一个平面晶格卷成一个锥面
%  pos为平面晶格坐标，radius为半径

 pos=timePOS(pos,20);
  pos=movePOS(pos,[0 0 0]);
  x=pos(:,1);
  y=pos(:,2);
  z=pos(:,3);
  
  r=radius;
  
  sita=x/r;
  beta=y/r;
  gamma=sqrt(x.^2+y.^2)/r;
  
  x1=(z+radius).*sin(sita);
  y1=(z+radius).*sin(beta);
  z1=(z+radius).*sin(gamma); 
  
  data=[x1 y1 z1];
  
  data=timePOS(data,1/20);
  data=movePOS(data,[0.5 0.5 0.5]);
  
  data=unique(data,'rows');

end

