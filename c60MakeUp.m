function [zuhe,hang]=c60MakeUp(n1,n2)
%������һ��ԭ����ϣ�����n=3,���г����п��ܵ�C60���滻3��ԭ�Ӷ�Ӧ��2Ԫ��ϡ�
% �˽ű��������Ѿ���c60Expandȡ����
% 
tic;

zuhe=0;
hang=0;

if(n1 <= n2)
   disp 'n1 must be greater than n2!';
   return;
end

if(n2 < 0)
   disp 'n2 must be positive number!';
   return;
end

index_r=0;
load('mat/c60/c60');
load('mat/c60/clist');

% top=c60Bx(n1);
% sub=c60Bx(n2);

top=eval(['c',num2str(n1)]);
sub=eval(['c',num2str(n2)]);

zuhe=cell(size(top,1),1);
hang=zeros(size(top,1),nchoosek(n1,n2));

for i=1:size(top,1)
    tmp=nchoosek(top(i,:),n2);
    tmp=sort(tmp,2);
    for j=1:size(tmp,1)
        
       findIn=unique(sort(index_r(tmp(j,:),:))','rows');
       zuhe{i,j}=findIn(1,:);
       hang(i,j)=find(ismember(sub,findIn(1,:),'rows'));
    end
    
end

% eval(['save ','mat/c60/','hang/',num2str(n2),'_',num2str(n1),' hang;']);
% eval(['save ','mat/c60/','zuhe/',num2str(n2),'_',num2str(n1),' zuhe;']);

toc;

end