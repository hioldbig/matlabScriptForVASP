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

n=5;
step=6;

% load(['new/CNsystem/compEn/',num2str(n)]);  

load(['new/CNsystem/compEn/',num2str(n),'_',num2str(step)]);

E60=-531.06659;
E59=-529.728600;         %-527.68125;   % for C59B or C59N
E1=E59-E60;

list=compEn(:,1);
compEn=compEn(:,2);
num=size(compEn,1);

energy=0;

E1=n*E1*ones(num,1);   % single

load(['new/energy/2_',num2str(n)]);  %pair
E2=energy(list);

load(['new/energy/3_',num2str(n)]);  %triplet
E3=energy(list);

load(['new/energy/4_',num2str(n)]);  %quadruplet
E4=energy(list);

x=[E1 E2 E3 E4];
y=compEn-E60*ones(num,1);

[b, bint, r, rint, stats] = regress(y, x);
error=sqrt(sum(r.^2,1)/size(r,1));

result=[b' error];

% eval(['save new/CNsystem/fit/', num2str(n), ' b error r']);
% eval(['save new/CNsystem/fit/', num2str(n),'_',num2str(step), ' b error r']);

