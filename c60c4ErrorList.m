function list=c60c4ErrorList(n)
%�����Щ������4��Bԭ�ӵĻ��ṹ��ֻ�е�n>=5ʱ����Ч��

load(['mat/c60/hang/4_',num2str(n)]);

[list6,i]=find(hang==6);
[list9,j]=find(hang==9);

list=unique([list6;list9]);

end