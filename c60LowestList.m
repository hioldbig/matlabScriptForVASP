function myList=c60LowestList(n,m,fileID)
%  ����������У���ȡһ��������������͵�m�����͡�
%  n��B�ĸ���
%  m�ǻ�ȡ�Ĺ��͵ĸ���
%  fileID��ǰһ�ε���������洢�ļ���

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

