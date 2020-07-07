function pos= bowlPOS2(n,radius,d)
%  将两个完整的碗状球面合在一起构成一个球面
%  n为每个碗对应的六边形的三角晶格的边上的点数，radius为碗的半径,d为两个碗的中心距离
  
  pos=bowlPOS(n,radius );
  data=bowlPOS(n,radius );

  data=myRotate(data,[0 0 pi/12]);
  
  data(:,3)=1-data(:,3);
  
  pos=movePOS(pos,[0.5 0.5 0.5+d/2]);  
  data=movePOS(data,[0.5 0.5 0.5-d/2]);
  
  pos=[pos;data];
  
end

