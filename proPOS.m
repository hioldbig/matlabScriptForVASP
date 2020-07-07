function point = proPOS(filename, points,h )
% filename is the data file
% points is the number of the referring points
% h is the height of the point to the center of the referring points

load(filename); %���������ļ�

center=mean(poscar);  %�������ĵ�����

for i=1:1:3;
    poscar(:,i)= poscar(:,i)-center(:,i);
end;    %ƽ�Ƶ�����ԭ��

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
             continue  %�ų����ĵ�          
      end        
      tmp = sum(tmp)/size(tmp,1);
      if size(point) == 0
          point = [point;tmp];
      else 
          if (find(sqrt(sum((ones(size(poscar,1),1)*tmp-poscar).^2,2)) < 0.07))
              continue  %�ų�ԭ��������������
          elseif (find(sqrt(sum((ones(size(point,1),1)*tmp-point).^2,2)) < 0.05))
              continue  %�ų�����̫���ĵ�����
          else
              point = [point;tmp];
          end
      end
    end 
end  %��ȡ���꣬���ֻ��һ���㣬��ֱ�ӻ�ȡ����㣬�����������ȡ��Щ��ĶԳ����ĵ�����

tmp=[];
for m=1:size(point,1)
    r = norm(point(m,:).^2);
    if(r < 1e-4 ) 
        continue  %������*���������ظ��ģ�����ȥ���˲�
    end
    k= 1+ h/r;
    tmp = [tmp; k*point(m,:)];
end  %������������

point = tmp;

for i=1:1:3;
      point(:,i)= point(:,i)+center(:,i);
end;  %�����ƶ����굽ԭ����ԭ��

point = setdiff(point, poscar, 'rows');

end

