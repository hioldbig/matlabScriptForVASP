function newPOS = timePOS( pos, times )
% ���ڽ��Ŵص������������ľ���Ŵ󣬼��Ŵ��Ŵسߴ�
% ���ֻ��һ��ԭ�ӣ��򲻻����κθı䡣
% ����1Ϊԭʼ�Ŵ����꣬������Ϊ�Ŵ�����

  if(size(pos,1)>1)
    center = mean(pos);
  else
    center = pos;  
  end
  
  pos = movePOS(pos,[0 0 0]);
  
  pos = pos.*times;
  
  pos = movePOS(pos,center);
  
  newPOS = pos;
  
end

