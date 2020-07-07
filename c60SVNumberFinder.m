function number= c60SVNumberFinder( n,sv )
% find the number for the SV
% for example n=3, sv=[1 2 7], number will be 5

list1=[];
beishu=61.^(n-1:-1:0)';
load(['new\c60\clist\',num2str(n)]);

list1=list1*beishu;

sv=c60Finder(sv);

sv=sv*beishu;

number=find(list1==sv);

end

