%按照新的拟合方法拟合
%n的值是替换的数目
%step是拟合的步骤
%----------------------------------------------------------------
%  拟合操作步骤说明
%  1.选择一个初步的组合参数获得初次能量排序，相关脚本是 c60NewNextStep100，设step=1
%  2.从中选择前100个，用c60SubPOSCAR产生POSCAR文件，用来计算第一步DFT能量
%  3.将能量存入到最新的compEn中，用c60chkIfReached检查这一步带来多少新的前100结构。
%  4.用c60NewDoFit进行拟合
%  5.重复以上步骤。
%  用c60NewFittingResults来获得完整的拟合数据。

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

