function c60ChkIfReached(n,fileID)
% �����ϲ����Ƿ��Ѿ������������Ǽ���ǰ100������������Ƿ����µĳ�Ա���롣
% n���滻Ժ�ӵĸ�����

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

