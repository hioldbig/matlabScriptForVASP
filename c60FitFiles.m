function c60FitFiles(n,fileID)
%生成获得拟合系数所用的数据，即生成目前所有已经计算的构型的计算总能，以及对应的2、3、4粒子组合的能量的列表，以供c60DoFit调用。
%  n为B的个数

enList=0;
yisuan=0;
compEn=0;

load(['mat/c60/enList/',num2str(n)]);
load(['mat/c60/yisuan/',num2str(n),'_1',num2str(fileID)]);
load(['mat/c60/compEn/',num2str(n),'_1',num2str(fileID)]);

fitData=zeros(size(yisuan,1),4);

fitData(:,1)=compEn(:,2);

fitData(:,2:4)=enList(yisuan,2:4);

eval(['save mat/c60/fit/',num2str(n),'_1',num2str(fileID),' fitData']);

end

