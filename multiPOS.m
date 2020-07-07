function multiPOS(dataDir)
%PRO92 Summary of this function goes here
%Detailed explanation goes here

num1=[12 20 30];
num2=[12 20 60];
zuhe=[];
bv=20*eye(3); %basis vector

for i=1:3;
  com = combntns(1:3,i);
  for j=1:size(com,1)
     zuhe1=[];
     zuhe2=[];
     for k=1:size(com,2)
        zuhe1=[zuhe1 num1(1,com(j,k))];
        zuhe2=[zuhe2 num2(1,com(j,k))];
     end
     zuhe1=[zuhe1 ,zeros(1,3-length(zuhe1))];
     zuhe2=[zuhe2 ,zeros(1,3-length(zuhe2))];
     zuhe=[zuhe;zuhe1;zuhe2];
  end
end

zuhe = unique(zuhe,'rows');

if isdir(['Data/',dataDir])
   disp 'Directory existing!';
   return;
end

load('Ag13');

cd('Data');
mkdir(dataDir);
cd(dataDir);

for i=1:size(zuhe,1)
    
    total = sum(zuhe(i,:),2);
    mkdir(num2str(total));  
    cd(num2str(total));
    
    for radius=5.3:0.1:5.5
       
       pos=[]; 
        
       for j=1:size(zuhe(i,:),2)
            if(zuhe(i,j)) 
              eval(['data = pro',num2str(zuhe(i,j)),'(',num2str(radius),');']);
              data=timePOS(data,radius/meanRadius(data,20));
              pos=[pos;data];
            end
        end

        fid = fopen(num2str(10*radius),'w');

        atoms = {'Ag','B'};
        num = [13 total];
        posHead(fid,atoms,num,bv);

        for ii=1:length(poscar) 
          fprintf(fid,'%8.4f',[poscar(ii,1),poscar(ii,2),poscar(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
        end

        for ii=1:length(pos) 
          fprintf(fid,'%8.4f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
        end
        fclose(fid);
        
    end
    
    cd ..
    
end

cd ../..

end

