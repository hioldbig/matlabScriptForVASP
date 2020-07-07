function [elements, counts] = myUnique(a)
% alternative unique operating for large number of int more than 1E7 

a = a(:);

if sum((a)~=round(a))>0
	error('a must be int!');
end


offsetA = min(a)-1;
a = a-offsetA;
counts = accumarray(a, 1);

elements = find(counts);
counts = counts(elements);
elements = elements+offsetA;

end
