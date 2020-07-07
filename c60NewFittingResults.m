% output the data for each fitting steps for n=5/6
% the data format is used to the energy level diagram for the fitting steps

n=9;
steps=10;   % �ܹ���ϵĲ���
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

for ii=2:steps  %��Ϊ��һ�����ܲ���100���칹�壬���Ե�һ�������������г��������2��ʼ��
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
for ii=1:steps  %i����ʼֵ�����2����ô��һ�����������firstRow,����ȫ��data�С�
   a=reshape(repmat((sort(list{ii})-lowest)',2,1),[],1);
   b=repmat([ii-width;(ii+width)],100,1);
   data=[data b a];
end

num=cell2mat(reshape(mat2cell(data(1:2,:),2,2*ones(steps,1)),[],1));
no100=[num(:,1) no100];
no30=[num(:,1) no30];

