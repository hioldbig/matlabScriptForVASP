function data = C60atomMove(poscar, points,h )
% ��ĳ��ԭ�����Ű뾶�����ƶ���hΪ��ʱ�������ƣ���������

center=mean(poscar);

for i=1:3
    poscar(:,i)= poscar(:,i)-center(:,i);
end 

data=[];

for p=1:size(points,2)

point= poscar(points(p),:);

r = norm(point);

k = 1+ h(p)/r;

point = k*point;

for i=1:3
    point(:,i)= point(:,i)+center(:,i);
end
    data=[data; point];
end

end