function list=c60c4ErrorList(n)
%获得那些有连续4个B原子的坏结构，只有当n>=5时才有效。

load(['mat/c60/hang/4_',num2str(n)]);

[list6,i]=find(hang==6);
[list9,j]=find(hang==9);

list=unique([list6;list9]);

end