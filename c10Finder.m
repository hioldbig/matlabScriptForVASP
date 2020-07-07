function str=c10Finder(array)
%find the equal array from the according sites list

n=size(array,2);

index=0;
load('c10/index.mat');

array=sort(array,2);

str=unique(sort(index(array,:))','rows');

str=str(1,:);

end

