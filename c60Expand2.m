function energy=c60Expand2(n,m)
% 获取集团展开的能量

% pre-define the var
list1=[]; 
hash=[];
r=[];

load(['new/hash/num/',num2str(m)]);
load(['new/c60/clist/',num2str(n)]);
load(['new/CNsystem/fit/',num2str(m)]);

cols=nchoosek(n,m);
dishu=100;
beishu=dishu.^(m-1:-1:0)';

tic
rows=size(list1,1);
energy=zeros(rows,1,'single');
for i=1:rows
    tmp=nchoosek(list1(i,:),m)*beishu;
    for j=1:cols
       energy(i)=energy(i)+r(hash(tmp(j,:)));
    end
end

eval(['save new/energy/',num2str(m),'_',num2str(n), ' -v7.3 energy;']);

toc
end