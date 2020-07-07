function result= c60subClusters( array,n,flag)
%获得某个指定的标号的大小为n的子团簇的所有标号，
% flag为标号所在的编号规则，1为systematic，2为我的初始编号规则。

if(size(array,2) <= n)
   disp 'n must be smaller than the cols of the array';
   return;
end

tmp=nchoosek(array,n);

result=zeros(size(tmp,1),size(tmp,2));

for i=1:size(tmp,1)
   result(i,:)=c60Finder(tmp(i,:),flag);
end

end

