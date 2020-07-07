function [Idx,Ctrs,SumD,D] = cluster( filename, layers )
%CLUSTER Summary of this function goes here
%   Detailed explanation goes here

load(filename);

center=mean(poscar);

len=[];

if(nargin < 2)
    layers = 2;
end;

for i=1:size(poscar,1);
   len=[len;norm(poscar(i,:)-center)];
end;
   opts = statset('Display','final');
   [Idx,Ctrs,SumD,D] = kmeans(len,layers,'Replicates',layers,'Options',opts);
   sort([poscar len],1)   
end

