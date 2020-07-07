function metal1_2_3OnGraphene(dataDir,cNum)
%to produce poscar files for 4 metal atoms above graphene of different
%number of Carbon and different enlarging force

% dataDir is the directory to store the output files,it is string type.
% cNum is the Carbon number of graphene, it is string type.

global bv;
global graphene;

atoms={
    'Li' 'Li_sv'    1.56
    'Ti' 'Ti_pv'    1.46
    'Pd' 'Pd'       1.38
 };


bv0=0;
bv=0;
graphene=0;

load('mat\graphene\graphene');

eval(['bv0=bv',cNum,';']);
eval(['graphene=c',cNum,';']);

cd('Data');
mkdir(dataDir);
cd(dataDir);

for percent=[0.00 0.01 0.03 0.05 0.07 0.08 0.09 0.10 0.15]
    
    mkdir(num2str(percent));
    cd(num2str(percent));

    bv=[bv0([1,2],:)*(1+percent);bv0(3,:)];

    for i=1:size(atoms,1)

        mkdir(atoms{i,1});

        cd(atoms{i,1});

%         %3 atoms
%         %T positions
%         pos=graphene([100,101,108],:);
%         saveFile(atoms{i,1},'T2',pos);
%         
%         pos=graphene([100,101,93],:);
%         saveFile(atoms{i,1},'T1',pos);
% 
%         %B positions
%         pos=[mean(graphene([36,101],:));mean(graphene([28,100],:));mean(graphene([35,108],:))];
%         saveFile(atoms{i,1},'B',pos);
%         
%         pos=[mean(graphene([29,101],:));mean(graphene([28,100],:));mean(graphene([36,108],:))];
%         saveFile(atoms{i,1},'B2',pos);
%         
%         %H positions
%         pos=[mean(graphene([35,101],:));mean(graphene([27,93],:));mean(graphene([28,94],:))];
%         saveFile(atoms{i,1},'H',pos);
% 
%         %2 atoms
%         %T positions
%         pos=graphene([100,101],:);
%         saveFile(atoms{i,1},'T',pos);
% 
%         %B positions
%         pos=[mean(graphene([36,101],:));mean(graphene([35,100],:))];
%         saveFile(atoms{i,1},'B',pos);
% 
%         pos=[mean(graphene([36,101],:));mean(graphene([28,93],:))];
%         saveFile(atoms{i,1},'B2',pos);
%         
%         %H positions
%         pos=[mean(graphene([35,101],:));mean(graphene([27,93],:))];
%         saveFile(atoms{i,1},'H',pos);
%         
%         
%         
%         %1 atom
%         %T position
%         pos=graphene(28,:);
%         saveFile(atoms{i,1},'T',pos);
%         
%         %B position
%         pos=mean(graphene([28,101],:));
%         saveFile(atoms{i,1},'B',pos);
%         
%         %H position
%         pos=mean(graphene([28,108],:));
%         saveFile(atoms{i,1},'H',pos);

          %H position
          pos=mean(graphene([13,20],:));
          saveFile(atoms{i,1},'H',pos);
          
          %B position
          pos=mean(graphene([20,21],:));
          saveFile(atoms{i,1},'B',pos);
        
        cd ..
    end
    cd ..
end

  cd ../..
  
end

function saveFile(atom,site,data)
     
     global bv;
     global graphene;

     file=['POSCAR_',atom,'_',num2str(size(data,1)),'_',site];
     fid = fopen(file,'w');

     atoms = {atom,'C'};
     num = [size(data,1),size(graphene,1)];
     posHead(fid,atoms,num,bv);

     data(:,3)=0.60;
     
     for ii=1:size(data,1) 
          fprintf(fid,'%12.6f',[data(ii,1),data(ii,2),data(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end
     
     for ii=1:length(graphene) 
          fprintf(fid,'%12.6f',[graphene(ii,1),graphene(ii,2),graphene(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end

     fclose(fid);

end