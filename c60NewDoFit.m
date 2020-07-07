%�����µ���Ϸ������
%n��ֵ���滻����Ŀ
%step����ϵĲ���
%----------------------------------------------------------------
%  ��ϲ�������˵��
%  1.ѡ��һ����������ϲ�����ó�������������ؽű��� c60NewNextStep100����step=1
%  2.����ѡ��ǰ100������c60SubPOSCAR����POSCAR�ļ������������һ��DFT����
%  3.���������뵽���µ�compEn�У���c60chkIfReached�����һ�����������µ�ǰ100�ṹ��
%  4.��c60NewDoFit�������
%  5.�ظ����ϲ��衣
%  ��c60NewFittingResults�����������������ݡ�

n=4;
%step=6;

workDir='new/CBsystem/fit_adopted/';   % for B
%workDir='new/CNsystem/';  % for N

load([workDir,'compEn/',num2str(n)]);  

%load([workDir,'compEn/',num2str(n),'_',num2str(step)]);

E60=-531.06659;
%E59=-529.72860;   % for C59N
E59=-527.68125;    % for C59B
E1=E59-E60;

compEn([6,9],:)=[];

list=compEn(:,1);
compEn=compEn(:,2);
num=size(compEn,1);

hang=0;

E1=n*E1*ones(num,1);   % single
x=E1;

load([workDir,'fit/2']);     % pair
E2=zeros(num,1);
com=nchoosek(n,2);
load(['new/hang/2_',num2str(n)]);
hang=hang(list,:);
for i=1:num
    for j=1:com
       E2(i)=E2(i)+r(hang(i,j));
    end
end
x=[x E2];

load([workDir,'fit/3']);     % triplet
E3=zeros(num,1);
com=nchoosek(n,3);
load(['new/hang/3_',num2str(n)]);
hang=hang(list,:);
for i=1:num
    for j=1:com
       E3(i)=E3(i)+r(hang(i,j));
    end
end
x=[x E3];

% load([workDir,'fit/4']);     % quadruplet
% E4=zeros(num,1);
% com=nchoosek(n,4);
% load(['new/hang/4_',num2str(n)]);
% hang=hang(list,:);
% for i=1:num
%     for j=1:com
%        E4(i)=E4(i)+r(hang(i,j));
%     end
% end
% x=[x E4];

y=compEn-E60*ones(num,1);

[b, bint, r, rint, stats] = regress(y, x);
error=sqrt(sum(r.^2,1)/size(r,1));

result=[b' error];

%eval(['save ',workDir,'fit/', num2str(n), ' b error r']);
%eval(['save ',workDir,'fit/', num2str(n),'_',num2str(step), ' b error r']);

