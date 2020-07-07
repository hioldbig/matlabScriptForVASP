%获得某个六边形的中心坐标，然后计算所有原子到此中心的距离，按照距离从小到大排序，将原坐标(C60) 重新排序。

clear;
close all;

load('mat/c60/c60');

dist=[];

p6=mean(c60([1,2,8,20,19,7],:));

for i=1:size(c60,1)
  tmp=c60(i,:)-p6;
  dist=[dist;norm(tmp)];
end

c60_r=[c60 dist]

sortrows(c60_r,4)
    

