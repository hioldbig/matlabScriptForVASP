function data = c60N2tongji( vectors,n,flag)
%统计n体作用的个数排行
  
  a=[];
  for i=1:size(vectors,1)
      a=[a; c60subClusters(vectors(i,:),n,flag)];
  end
  
  b=unique(a,'rows');
  
  data=zeros(size(b,1),2); 
  
  for i=1:size(b,1) 
      data(i,1)=b(i,2); 
      data(i,2)=sum(ismember(a,b(i,:),'rows'),1); 
  end
  
  data=sortrows(data,2);
  
end

