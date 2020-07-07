function c60ChkIfReached(n,fileID)
% 检查拟合参数是否已经收敛，方法是检验前100名最低能量中是否有新的成员加入。
% n是替换院子的个数。

chkNum=100;
compEn=[];

if fileID<2
   disp 'all 100 lowest ones born!';
   return;
end

load(['new/CNsystem/compEn/',num2str(n),'_',num2str(fileID-1)]);

list0=compEn;

load(['new/CNsystem/compEn/',num2str(n),'_',num2str(fileID)]);

list1=compEn;

list0=sortrows(list0,2);
list0=list0(1:chkNum,1);

list1=sortrows(list1,2);
list1=list1(1:chkNum,1);


added=setdiff(list1,list0);

size(added,1)

end

