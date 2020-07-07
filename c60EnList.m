function c60EnList(n,subs)
%获取各种组合总能

% n为计算的目标所含替换原子个数，例如6
% subs是将要被作为拟合的组合系列的原子个数，例如[2,3,4]


m=subs(length(subs));

for i=subs
 eval(['load(''','mat/c60/hang/',num2str(i),'_',num2str(n),''');']);
 eval(['load(''','mat/c60/zuoyong/',num2str(i),''');']);
 
 eval(['niheEn_',num2str(i),'=','zeros(size(hang_',num2str(i),'_',num2str(n),',1),1);']);
 
 row=eval(['size(','hang_',num2str(i),'_',num2str(n),',1)']);
 col=eval(['size(','hang_',num2str(i),'_',num2str(n),',2)']);
 
 for j=1:row
   tmp=0;
   for k=1:col
     eval(['tmp=tmp+','zuoyong_',num2str(i),'(','hang_',num2str(i),'_',num2str(n),'(',num2str(j),',',num2str(k),'));']);
   end
     eval(['enList_',num2str(i),'(',num2str(j),')','=tmp;']);
 end 
 
end

ids=zeros(row,1);

for i=1:row
    ids(i)=i;
end

enList=zeros(row,m);

enList(:,1)=ids;

for i=subs
     enList(:,i)=eval(['enList_',num2str(i)]);
end

eval(['save mat/c60/enList/',num2str(n),' enList']);

end

