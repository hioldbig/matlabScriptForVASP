function data= ball2plane( pos)
% ���Խ�������ƽ�棬ע�⣺�����ǳ��ԣ�Ч����̫�ã���Ϊ���治����չ��Ϊƽ��
% ����Ϊ���棨���ӣ��Ŵص�����

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

