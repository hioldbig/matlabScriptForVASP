function multiSanjiao( dataDir )
%MULTISANJIAO Summary of this function goes here
%   Detailed explanation goes here

bv=20*eye(3); 
max_n=6;

if isdir(dataDir)
   disp 'Directory existing!';
   return;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

for n=2:max_n;
       
       pos=sanjiao(n);
       fid = fopen(num2str(n),'w');
     
        atoms = {'B'};
        num = 3*n*n-3*n+1;
        posHead(fid,atoms,num,bv);

        for ii=1:length(pos) 
          fprintf(fid,'%8.4f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
        end
        fclose(fid);
end

cd ../..
        
end

