function hang=c60Expand(n,m,method)
%���c60MakeUp���·��������cluster��չ���б��г���4�в�ͬ�ķ��������ǵ��ٶȲ�ͬ��

 if(method==1)
     hang=expand1(n,m);
 elseif (method==2)
     hang=expand2(n,m);
 elseif (method==3)
     hang=expand3(n,m);
 else
     hang=expand4(n,m);
 end
 
%  eval(['save new/hang/',num2str(m),'_',num2str(n), ' -v7.3 hang;']);

end

function makeUp=expand1(n,m)
% ���������Ĺ�ϣ��+˫��ѭ��

% pre-define the var
list1=[]; 
hash=[];

load(['new/hash/num/',num2str(m)]);
load(['new/c60/clist/',num2str(n)]);

cols=nchoosek(n,m);
dishu=100;
beishu=dishu.^(m-1:-1:0)';

tic
rows=size(list1,1);
makeUp=ones(rows,cols,'uint8');
for i=1:rows
    tmp=nchoosek(list1(i,:),m)*beishu;
    for j=1:cols
       makeUp(i,j)=hash(tmp(j,:));
    end
end

toc
end

function makeUp=expand2(n,m)
% ����������hash����arrayfun+����ѭ��

% pre-define the var
list1=[]; 
hash=[];

load(['new/hash/num/',num2str(m)]);
load(['new/c60/clist/',num2str(n)]);

cols=nchoosek(n,m);
dishu=100;
beishu=dishu.^(m-1:-1:0)';

tic

list1=num2cell(list1,2);
F=@(x) nchoosek(x{:},m)*beishu;
makeUp=num2cell(cell2mat(arrayfun(F,list1,'UniformOutput',false)));

for i=1:size(makeUp,1)
    makeUp{i}=hash(makeUp{i});
end

makeUp=reshape(cell2mat(makeUp),cols,[])';

toc
end

function makeUp=expand3(n,m)
% �ַ���ϣ��+˫��ѭ��

% pre-define the var
list1=[]; 
hash=[];

load(['new/hash/str/',num2str(m)]);
load(['new/c60/clist/',num2str(n)]);

rows=size(list1,1);
cols=nchoosek(n,m);
makeUp=ones(rows,cols,'uint8');
tic
for i=1:rows
    tmp=num2str(nchoosek(list1(i,:),m),'%02d');
    for j=1:cols
       makeUp(i,j)=hash(tmp(j,:));
    end
end
toc
end

function makeUp=expand4(n,m)
% ����������ϣ+arrayfun

% pre-define the var
list1=[]; 
hash=[];

load(['new/hash/num/',num2str(m)]);
load(['new/c60/clist/',num2str(n)]);

num=nchoosek(n,m);
dishu=100;
beishu=dishu.^(m-1:-1:0)';

list1=num2cell(list1,2);

tic;

F=@(x) nchoosek(x{:},m)*beishu;
makeUp=num2cell(reshape(cell2mat(arrayfun(F,list1,'UniformOutput',false)),num,[])');

F1=@(x) hash(x{:});
makeUp=cell2mat(arrayfun(F1,makeUp,'UniformOutput',false));

toc;

end