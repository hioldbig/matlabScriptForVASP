function AgBPOS1(dataDir, n, radius)
%AGBPOS Summary of this function goes here
%   Detailed explanation goes here

bv=26*eye(3); 
oldBv=20*eye(3);

load('mat/Ag/Ag13');
  
data=bowlPOS(n,radius );

kongwei=[3,6,9,54,55,60,61];
data(kongwei,:)=[];   % when n=5,remove 5 atoms

if isdir(dataDir)
   disp 'Directory existing!';
   return;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

total=size(data,1);

for d=0.53:0.03:0.62
        
  mkdir(num2str(d))
        
  cd(num2str(d))
 
 for alpha=-0.3:0.3:0.3

  for beta=-0.3:0.3:0.3
    
%     for gamma=-0.3:0.3:0.3
        
        pos=movePOS(data,[0.5 0.5 d]);  
        fid = fopen([num2str(0.3+alpha),'_',num2str(0.3+beta),'_',num2str(0.3+0)],'w');

        atoms = {'Ag','B'};
        num = [13 total];
        posHead(fid,atoms,num,bv);

        Ag13=myRotate(poscar,[alpha,beta,0]);
        
        pos2=[Ag13;pos];
        
        pos2=changeBv(pos2,oldBv,bv);

        for ii=1:length(pos2) 
            fprintf(fid,'%8.4f',[pos2(ii,1),pos2(ii,2),pos2(ii,3)]);
            fprintf(fid,'\tT\tT\tT\n');
        end

        fclose(fid);
        
%      end
  end
 end
  
  cd ..
  
end

cd ../..

end

