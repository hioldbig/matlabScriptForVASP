function result= c60subClusters( array,n,flag)
%���ĳ��ָ���ı�ŵĴ�СΪn�����Ŵص����б�ţ�
% flagΪ������ڵı�Ź���1Ϊsystematic��2Ϊ�ҵĳ�ʼ��Ź���

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

