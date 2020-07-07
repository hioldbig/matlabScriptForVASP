%将旧的编号批量变成新的编号。

b=zeros(size(a,1),size(a,2));
for ii=1:size(a,1)
   b(ii,:)=c60Numbering(a(ii,:),1);
end