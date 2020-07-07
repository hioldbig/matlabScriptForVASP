function newPOS = timePOS( pos, times )
% 用于将团簇的坐标点对其中心距离放大，即放大团簇尺寸
% 如果只有一个原子，则不会有任何改变。
% 参数1为原始团簇坐标，参数二为放大倍数。

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

