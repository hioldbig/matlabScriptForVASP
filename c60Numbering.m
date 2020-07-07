function nsv= c60Numbering(sv,flag)
%transfer the structure vectors from one numbering system to another one
% flag=1,means transfer VS from my numbering to the systematic one
% flag!=1, the inverse action will be done

sn=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60];
pn=[7,13,9,1,5,4,8,19,20,26,34,23,32,25,18,16,10,3,2,6,11,14,22,31,27,38,47,50,41,44,51,46,37,28,35,24,15,12,21,17,29,33,40,42,53,55,60,56,58,52,45,43,36,30,39,48,49,59,57,54];

index_r=0;
load('mat/c60/c60');

if flag==1
    
index_rr=index_r;

for i=1:size(index_r,1)
   tmp=index_r(i,:);
   for j=1:size(index_r,2)
     tmp(j)=sn(pn==index_r(i,j));
   end
   index_rr(i,:)=tmp;
end

index_rr=sortrows(index_rr,1);

end

nsv=sv;

for j=1:size(sv,1)

tmp=ones(1,size(sv,2));

for i=1:size(sv,2)
    if flag==1
      tmp(i)=sn(pn==sv(j,i));
    else 
      tmp(i)=pn(sn==sv(j,i));
    end
end

tmp=sort(tmp,2);

if flag==1
  tmp=unique(sort(index_rr(tmp,:))','rows');
else
  tmp=unique(sort(index_r(tmp,:))','rows');
end

tmp=tmp(1,:);

nsv(j,:)=tmp;

end

end

