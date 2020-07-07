function point = proPOS(filename, points,h )
% filename is the data file
% points is the number of the referring points
% h is the height of the point to the center of the referring points

load(filename); %导入坐标文件

center=mean(poscar);  %计算中心点坐标

for i=1:1:3;
    poscar(:,i)= poscar(:,i)-center(:,i);
end;    %平移到坐标原点

point=[];
if points == 1
    for nn=1:size(poscar,1)
      tmp = poscar(nn,:);
      if (sqrt(sum(tmp.^2,2)) < 0.01)
          continue
      end
      point=[point;tmp];
    end
else 
    combos=combntns(1:size(poscar,1),points);
    for nn=1:size(combos,1)
      tmp = poscar(combos(nn,:)',:);
      if (find(sqrt(sum((ones(size(tmp,1),1)*[0 0 0]-tmp).^2,2)) < 0.01))
             continue  %排除中心点          
      end        
      tmp = sum(tmp)/size(tmp,1);
      if size(point) == 0
          point = [point;tmp];
      else 
          if (find(sqrt(sum((ones(size(poscar,1),1)*tmp-poscar).^2,2)) < 0.07))
              continue  %排除原笼子所属点坐标
          elseif (find(sqrt(sum((ones(size(point,1),1)*tmp-point).^2,2)) < 0.05))
              continue  %排除靠的太近的点坐标
          else
              point = [point;tmp];
          end
      end
    end 
end  %获取坐标，如果只有一个点，则直接获取坐标点，如果多个，则获取这些点的对称中心点坐标

tmp=[];
for m=1:size(point,1)
    r = norm(point(m,:).^2);
    if(r < 1e-4 ) 
        continue  %与上面*处计算是重复的，可以去掉此步
    end
    k= 1+ h/r;
    tmp = [tmp; k*point(m,:)];
end  %计算最终坐标

point = tmp;

for i=1:1:3;
      point(:,i)= point(:,i)+center(:,i);
end;  %重新移动坐标到原来的原点

point = setdiff(point, poscar, 'rows');

end

