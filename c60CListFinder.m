function c60CListFinder(n)
%���2��3��4�����ӵ�������ϵĹ�ϣ��
%���ṩ������Ŵص��ӽṹ�Ŀ��ٻ�á�

load('mat/c60/clist');

v=1:1:60;
v=nchoosek(v,n);
index=ones(size(v,1),1);
eval(['c=c',num2str(n),';']);
tic
for i=1:size(v,1)
   tmp=c60Finder(v(i,:));
   [~,row]=ismember(tmp,c,'rows');
   index(i)=row;
end
toc
eval(['save mat/c60/comb/c',num2str(n),' v index']);

end

