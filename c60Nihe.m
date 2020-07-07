function c60Nihe(n,subs,paras,fileID)
%按照c60DoFit获取的最佳线性拟合参数，获取各种多粒子的能量的组合值，即计算拟合能，以供c60LowestList来获取能量最低的若干个构型。

% n为计算的目标所含替换原子个数，例如6
% subs是将要被作为拟合的组合系列的原子个数，例如[2,3,4]
% paras是通过c60DoFit事先获得拟合参数,例如[0.9 0.3 0.1],如果没有，使用[1 1 1]即可。
%fileID是存储在目录niheEn下的结果的文件编号,例如2


m=subs(length(subs));

enList=[];

eval(['load(''','mat/c60/enList/',num2str(n),''');']);

row=size(enList,1);

niheEn=zeros(row,2);

niheEn(:,1)=enList(:,1);

for j=subs
  tmp=paras(subs==j);  
  niheEn(:,2)=niheEn(:,2) + tmp*enList(:,j);
end

eval(['save mat/c60/niheEn/',num2str(n),'_1',num2str(fileID),' niheEn']);

end

