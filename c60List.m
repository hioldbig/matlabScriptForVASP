%根据原子坐标获得对应的index表

clear
fclose('all');

load('mat/c60/c60');

index=zeros(60,120);

for i=1:size(sym,1)
 
  c60_new=sym{i}*c60';
  c60_new=c60_new';
  
  for j=1:size(c60,1)
     for k=1:size(c60_new,1)
       if(norm(c60_new(k,:)-c60(j,:))<0.1)
          index(j,i)=k;
          break;
       end
     end
     
  end
  
end

% save mat/c60/c60  index -append;

c60=c60_r;

for i=1:size(sym,1)
 
  c60_new=sym{i}*c60';
  c60_new=c60_new';
  
  for j=1:size(c60,1)
     for k=1:size(c60_new,1)
       if(norm(c60_new(k,:)-c60(j,:))<0.1)
          index(j,i)=k;
          break;
       end
     end
     
  end
  
end

index_r=index;

% save mat/c60/c60  index_r -append;