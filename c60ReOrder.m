%���ĳ�������ε��������꣬Ȼ���������ԭ�ӵ������ĵľ��룬���վ����С�������򣬽�ԭ����(C60) ��������

clear;
close all;

load('mat/c60/c60');

dist=[];

p6=mean(c60([1,2,8,20,19,7],:));

for i=1:size(c60,1)
  tmp=c60(i,:)-p6;
  dist=[dist;norm(tmp)];
end

c60_r=[c60 dist]

sortrows(c60_r,4)
    

