function multiPOS114(dataDir)
%MULTIPOS_A Summary of this function goes here
%   Detailed explanation goes here

bv=26*eye(3); 
oldBv=20*eye(3);

if isdir(dataDir)
   disp 'Directory existing!';
   return;
end

load('Ag13');
load('B114');

cd('Data');
mkdir(dataDir);
cd(dataDir);

for radius=4.4:0.3:5.0;

    mkdir(num2str(radius));
    cd(num2str(radius));
    
    for sita=0:pi/6:pi/3
      for alpha=0:pi/6:pi/3
         for gamma=0:pi/6:pi/3
       
           fid = fopen([num2str(10*sita),'_',num2str(10*alpha),'_',num2str(10*gamma)],'w');

            atoms = {'Ag','B'};
            num = [13 114];
            posHead(fid,atoms,num,bv);

            Ag13=myRotate(poscar,[sita,alpha,gamma]);
            Ag13=changeBv(Ag13,oldBv,bv);
            
            B114=timePOS(B114,radius/meanRadius(B114,26));
        
            pos2=[Ag13;B114];

            for ii=1:length(pos2) 
                fprintf(fid,'%8.4f',[pos2(ii,1),pos2(ii,2),pos2(ii,3)]);
                fprintf(fid,'\tT\tT\tT\n');
            end

            fclose(fid);
             
         end
         
       end
        
    end
    cd ..
end    

cd ../..

end

