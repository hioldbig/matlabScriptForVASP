function data=ballPOS1(n)
% 在三角晶格的基础上按照需要挖洞，然后卷成碗状，然后将两个碗合成一个球面
% n为所依赖的六边形三角晶格的一边上的点数。

  r=1.7;
  pos=sanjiao(n);
  radius=(2*(n-1)*(1+sqrt(3)/2)+1)*r/2/pi;
  data1=getBowl(n,pos,radius,1);
  data2=getBowl(n,pos,radius,2);
  
  kongwei=[1,4,7,30,31,36,37];
%   kongwei=[4];
  data1(kongwei,:)=[];   % when n=5,remove 5 atoms
  
%   kongwei=[4];
  data2(kongwei,:)=[];   % when n=5,remove 5 atoms
  
  data=[data1;data2];
  
  data=timePOS(data,1/20);
  
  data=movePOS(data,[0.5 0.5 0.5]);
  
end

%获得碗状曲面
function data=getBowl(n,pos,radius,flag)
  pos=timePOS(pos,20);
  pos=movePOS(pos,[0 0 0]);
  x=pos(:,1);
  y=pos(:,2);
  z=pos(:,3);
  
  sita=sqrt(x.^2+y.^2)/radius;
  beta=atan(y./x);
  beta(find(x<0))=beta(find(x<0))+pi;
  
  if(flag==2)
     sita=pi-sita; 
     beta=beta+pi/12;
  end
  
  x1=radius*sin(sita).*cos(beta);
  y1=radius*sin(sita).*sin(beta);
  z1=radius*cos(sita); 
  
  data=[x1 y1 z1]; 

end

