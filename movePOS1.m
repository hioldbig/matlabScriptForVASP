function newPOS = movePOS1( oldPOS, newCenter )
% ���Ŵص����ĵ��Ƶ��µ�λ��
% ����Ŵ�ֻ��һ���㣬��ֱ�ӽ��õ��Ƶ�Ŀ�������
% ����1Ϊ�Ŵ�����㣬����2Ϊ�µ�����λ�á�

if(size(oldPOS,1)>1)
  center = mean(oldPOS);
else
  center = oldPOS;  
end

% ���������ԭ�㣬������������0-1�ķ�Χ�ڣ�����vesta����ʾ��
if(norm(center-zeros(1,3))<0.01) 
  INDEX=find(oldPOS>0.5);
  oldPOS(INDEX)=oldPOS(INDEX)-1;
end

cha=newCenter-center;

if(norm(cha)<0.01)   % �Ѿ�λ��Ŀ�ĵ㣬�����ƶ�
    newPOS=oldPOS;
else
    for i=1:1:3;
      oldPOS(:,i)= oldPOS(:,i)+cha(:,i);
    end;  
    newPOS = oldPOS;
end


end

