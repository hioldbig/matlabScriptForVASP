function data=bowlPOS(n,radius )
%   ��һ���������ĶԳƵ�6���ε����Ǿ���ƽ����һ����״����
%   nΪ���Ǿ����6�Ǳ��ϵ�ԭ�Ӹ�����

  pos=sanjiao(n);
  pos=timePOS(pos,20);
  pos=movePOS(pos,[0 0 0]);
  x=pos(:,1);
  y=pos(:,2);
  z=pos(:,3);
  
  sita=sqrt(x.^2+y.^2)/radius;
  beta=atan(y./x);
  
  beta(find(x<0))=beta(find(x<0))+pi;
  
  x1=radius*sin(sita).*cos(beta);
  y1=radius*sin(sita).*sin(beta);
  z1=radius*cos(sita); 
  
  data=[x1 y1 z1];
  
  data=timePOS(data,1/20);
  data=movePOS(data,[0.5 0.5 0.5]);
 
end

