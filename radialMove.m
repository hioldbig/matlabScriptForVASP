function newPOS=radialMove(pos,d,flag)
% ���Ŵ����������Ķ�Ӧ��ʸ���ƶ�,d>0�����ƶ�����֮�����ƶ�
% flag=1Ϊ�����ƶ�ֵ������Ϊ����ƶ�ֵ

if(size(pos,1)>1)
    center=mean(pos);
else
    center=pos;
end

L0=norm(center);

if(flag==1) 
  k=d/L0;  % dΪ�����ƶ���
else 
  k=d;     % dΪ����ƶ���
end

center(:,:) = center(:,:)*(k+1);

newPOS=movePOS(pos,center);

end

