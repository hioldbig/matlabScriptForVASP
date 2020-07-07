function myList=c60LowestList(n,m,fileID)
%  从拟合能量中，获取一定数量的能量最低的m个构型。
%  n是B的个数
%  m是获取的构型的个数
%  fileID是前一次的拟合能量存储文件名

niheEn=0;
yisuan=[];

errors=c60c4ErrorList(n);

if(fileID>1)
  load(['mat/c60/yisuan/',num2str(n),'_1',num2str(fileID-1)]);
end

load(['mat/c60/niheEn/',num2str(n),'_1',num2str(fileID)]);

rest=setdiff(niheEn(:,1),union(errors,yisuan));

sorted=sortrows(niheEn(rest,:),2);

myList=sort(sorted(1:m,1));

yisuan=[yisuan;myList];

yisuan=sort(yisuan);

eval(['save mat/c60/yisuan/',num2str(n),'_1', num2str(fileID), ' yisuan']);

end

