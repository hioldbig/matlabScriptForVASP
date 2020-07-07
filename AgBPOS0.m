function AgBPOS0(n,radius,d)
%AGBPOS Summary of this function goes here
%   Detailed explanation goes here

bv=26*eye(3); 
oldBv=20*eye(3);

load('mat/Ag/Ag13');
  
data=bowlPOS(n,radius );

% kongwei=[1,4,7,30,31,36,37];
% data(kongwei,:)=[];   % when n=5,remove 5 atoms

total=size(data,1);

% data=movePOS(data,[0.5 0.5 d]);  
fid = fopen('./Data/POSCAR-bowl','w');

atoms = {'Ag','B'};
num = [13 total];
posHead(fid,atoms,num,bv);

pos2=[poscar;data];

pos2=changeBv(pos2,oldBv,bv);

for ii=1:length(pos2) 
    fprintf(fid,'%8.4f',[pos2(ii,1),pos2(ii,2),pos2(ii,3)]);
    fprintf(fid,'\tT\tT\tT\n');
end

fclose(fid);

end

