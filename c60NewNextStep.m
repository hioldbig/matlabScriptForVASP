%用1~4粒子作用拟合C55B5和C54B6时，
%获得每步拟合需要计算的100个新结构的编号和对应的能量，
%如果该结构尚未计算，则能量为0

n=8;
step=1;
isomers=100;

load('new/c60/clist/num');
num=num(n);

if step==1
   oldCompEn=[]; 
% coefficients of 4 used for initial fitting for C55B5   
%    load('new/CNsystem/fit/4.mat','b'); 
%    paras=[b; 1];
%coefficients of 6 used for initial fitting for 7
     load('new/CNsystem/fit/7_6.mat','b');  
     paras=b; 
% %constant coefficients used for initial fitting for C54B6
%      paras=[1;1;1;1];
else
   load(['new/CNsystem/compEn/',num2str(n),'_',num2str(step-1)]); 
   oldCompEn=compEn;
   load(['new/CNsystem/fit/',num2str(n),'_',num2str(step-1),'.mat'],'b');
   paras=b;
end

% errors=c60c4ErrorList(n);
errors=[]; % CN 体系不会有类似CB那样的坏结构。

rest=setdiff(1:num,union(errors,oldCompEn));

E60=-531.06659;
E59=-529.728600;         %-527.68125;   % for C59B or C59N
E1=E59-E60;

E1=n*E1*ones(num,1);   % single

load('new/CNsystem/fit/2');     % pair
E2=zeros(num,1);
com=nchoosek(n,2);
load(['new/hang/2_',num2str(n)]);
for i=1:num
    for j=1:com
       E2(i)=E2(i)+r(hang(i,j));
    end
end

load('new/CNsystem/fit/3');     % triplet
E3=zeros(num,1);
com=nchoosek(n,3);
load(['new/hang/3_',num2str(n)]);
for i=1:num
    for j=1:com
       E3(i)=E3(i)+r(hang(i,j));
    end
end

load('new/CNsystem/fit/4');     % quadruplet
E4=zeros(num,1);
com=nchoosek(n,4);
load(['new/hang/4_',num2str(n)]);
for i=1:num
    for j=1:com
       E4(i)=E4(i)+r(hang(i,j));
    end
end

E=[E1 E2 E3 E4]*paras;

E=[(1:size(E,1))' E];

E=sortrows(E(rest,:),2);

list=E(1:isomers,:);
list=list(:,1);

newCompEn=[list zeros(isomers,1)];

% load(['new/CNsystem/compEn/',num2str(n)]);
% for i=1:size(list,1)
%    tmp=find(compEn(:,1)==list(i));
%    if(tmp) 
%        newCompEn(i,2)=compEn(tmp,2);
%    end   
% end

compEn=[newCompEn;oldCompEn];

save(['new/CNsystem/compEn/',num2str(n),'_',num2str(step)],'compEn');


