function newPOS = movePOS( oldPOS, newCenter )
% 将团簇的中心点移到新的位置
% 如果团簇只有一个点，则直接将该点移到目标坐标点
% 参数1为团簇坐标点，参数2为新的中心位置。

if(size(oldPOS,1)>1)
  center = mean(oldPOS);
else
  center = oldPOS;  
end

cha=newCenter-center;

if(norm(cha)<0.01)   % 已经位于目的点，无需移动
    newPOS=oldPOS;
else 
    for i=1:1:3;
      oldPOS(:,i)= oldPOS(:,i)+cha(:,i);
    end;  
    newPOS = oldPOS;
end

end



