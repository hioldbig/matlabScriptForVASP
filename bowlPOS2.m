function pos= bowlPOS2(n,radius,d)
%  ��������������״�������һ�𹹳�һ������
%  nΪÿ�����Ӧ�������ε����Ǿ���ı��ϵĵ�����radiusΪ��İ뾶,dΪ����������ľ���
  
  pos=bowlPOS(n,radius );
  data=bowlPOS(n,radius );

  data=myRotate(data,[0 0 pi/12]);
  
  data(:,3)=1-data(:,3);
  
  pos=movePOS(pos,[0.5 0.5 0.5+d/2]);  
  data=movePOS(data,[0.5 0.5 0.5-d/2]);
  
  pos=[pos;data];
  
end

