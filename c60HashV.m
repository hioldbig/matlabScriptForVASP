function c60HashV(n, method)
% 建立2，3，4的cluster的哈希表，用于高浓度的cluster的展开。   

   if (method=='str')
       strHash(n);
   else
       numHash(n);
   end

end
function strHash(n)
%字符索引的哈希表

load(['mat/c60/comb/c',num2str(n)]);

data=cellstr(num2str(v,'%02d'));

hash=containers.Map(data,index);

% eval(['save mat/c60/comb/c',num2str(n), ' hash -append']);

eval(['save new/hash/str/',num2str(n), ' hash']);

end

function numHash(n)
%数字索引的哈希

load(['mat/c60/comb/c',num2str(n)]);

dishu=100;
beishu=dishu.^(n-1:-1:0)';

% v=v*beishu;
v=single(v*beishu);

hash=containers.Map(v,index);

% eval(['save mat/c60/comb/c',num2str(n), ' hash1 -append']);

% eval(['save new/hash/num/',num2str(n), ' hash']);
eval(['save new/hash/num2/',num2str(n), ' hash']);

end

