function AgBPOS2(dataDir, n, radius)
%AGBPOS Summary of this function goes here
%   Detailed explanation goes here

bv=26*eye(3); 
oldBv=20*eye(3);

load('mat/Ag/Ag13-2');
  
data=bowlPOS(n,radius );

data(:,3)=1-data(:,3);

kongwei=[3,6,9,54,55,60,61];
data(kongwei,:)=[];   % remove atoms

if isdir(dataDir)
   disp 'Directory existing!';
   return;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

total=size(data,1);

for d=0.295:0.01:0.345
        
  mkdir(num2str(d))
        
  cd(num2str(d))
 
  for gamma=pi/5:pi/5:2*pi
        
        pos=movePOS(data,[0.5 0.5 d]);  
        fid = fopen(num2str(gamma),'w');

        atoms = {'Ag','B'};
        num = [13 total];
        posHead(fid,atoms,num,bv);

        Ag13=myRotate(poscar2,[0,0,gamma]);
        
        pos2=[Ag13;pos];
        
        pos2=changeBv(pos2,oldBv,bv);

        for ii=1:length(pos2) 
            fprintf(fid,'%8.4f',[pos2(ii,1),pos2(ii,2),pos2(ii,3)]);
            fprintf(fid,'\tT\tT\tT\n');
        end

        fclose(fid);
        
  end
  
  cd ..
  
end

cd ../..

end

