function data= ball2plane( pos)
% 尝试将球面变成平面，注意：仅仅是尝试，效果不太好，因为球面不可能展开为平面
% 参数为球面（笼子）团簇的坐标

pos=movePOS(pos,[0 0 0]);

x=pos(:,1);
y=pos(:,2);
z=pos(:,3);

r=sqrt(sum(pos.*pos,2));

sita=acos(z./r);
phi=atan(y./x);

for i=1:size(phi,1)
  if(y(i)==0)
      if(x(i)>0)
          phi(i)=0;
      else
          phi(i)=pi;
      end
  elseif(x(i)<0&&y(i)>0)
      phi(i)=pi+phi(i);
  elseif(x(i)<0&&y(i)<0)
      phi(i)=pi+phi(i);
  elseif(x(i)>0&&y(i)<0)
      phi(i)=2*pi+phi(i);
  end
  
end

x=r.*sita.*cos(phi);
y=r.*sita.*sin(phi);
% z=(sita>pi/2)*(-0.2)+(sita<pi/2)*0.2;
z=zeros(size(x,1),1);

data=[x y z];

data=movePOS1(data,[0.5 0.5 0.5]);
data=roundn(data,-6);

end

