function newPOS=radialMove(pos,d,flag)
% 将团簇沿着其中心对应的矢径移动,d>0往外移动，反之往内移动
% flag=1为绝对移动值，否则为相对移动值

if(size(pos,1)>1)
    center=mean(pos);
else
    center=pos;
end

L0=norm(center);

if(flag==1) 
  k=d/L0;  % d为绝对移动量
else 
  k=d;     % d为相对移动量
end

center(:,:) = center(:,:)*(k+1);

newPOS=movePOS(pos,center);

end

