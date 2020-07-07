function point = getpoint(poscar, points,h )
% filename is the data file
% points is the referring points
% h is the height of the point to the center of the referring points

center=mean(poscar);

for i=1:1:3;
    poscar(:,i)= poscar(:,i)-center(:,i);
end;    

point=[];
if numel(points) == 1
    point= poscar(points(1,1),:);
else 
    for i=1:1:numel(points)
    point= [point; poscar(points(1,i),:)];
    end
    point = sum(point)/size(point,1);
end

r = norm(point.^2);

k = 1+ h/r;

point = k*point;

for i=1:1:3;
    poscar(:,i)= poscar(:,i)+center(:,i);
    point(:,i)= point(:,i)+center(:,i);
end;

end

