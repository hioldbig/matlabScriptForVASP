% output the data for each fitting steps for n=5/6
% the data format is used to the energy level diagram for the fitting steps

n=9;
steps=10;   % 总共拟合的步数
width=0.3;

dataDir='new/CNsystem/compEn/';

load([dataDir,num2str(n),'_',num2str(steps)]);
lowest=min(compEn(:,2));

list=cell(steps,1);
no100=zeros(steps,1);
no30=zeros(steps,1);

load([dataDir,num2str(n),'_1']);
compEn=sort(compEn(:,2));
list{1}=compEn;
no100(1)=compEn(100)-lowest;
no30(1)=compEn(30)-lowest;

for ii=2:steps  %因为第一步可能不是100个异构体，所以第一步的数据另外列出，这里从2开始。
   load([dataDir,num2str(n),'_',num2str(ii)]);
   compEn1=compEn;
   load([dataDir,num2str(n),'_',num2str(ii-1)]);
   compEn2=compEn;
   
   compEn=setdiff(compEn1,compEn2,'rows');
   list{ii}=sort(compEn(:,2));
   
   compEn1=sort(compEn1(:,2));
   no100(ii)=compEn1(100)-lowest;
   no30(ii)=compEn1(30)-lowest;
   
end
%use this to get the column for each step
a=reshape(repmat((sort(list{1})-lowest)',2,1),[],1);
no100=reshape(repmat(no100',2,1),[],1);
no30=reshape(repmat(no30',2,1),[],1);

b=repmat([1-width;1+width],size(list{1},1),1);
firstRow=[b a];

data=[];
for ii=1:steps  %i的起始值如果是2，那么第一步拟合数据是firstRow,否则全在data中。
   a=reshape(repmat((sort(list{ii})-lowest)',2,1),[],1);
   b=repmat([ii-width;(ii+width)],100,1);
   data=[data b a];
end

num=cell2mat(reshape(mat2cell(data(1:2,:),2,2*ones(steps,1)),[],1));
no100=[num(:,1) no100];
no30=[num(:,1) no30];

