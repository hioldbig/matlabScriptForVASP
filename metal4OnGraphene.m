function metal4OnGraphene(dataDir,cNum)
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

pos=zeros(4,3);

bv0=0;
bv=0;
graphene=0;

load('mat/graphene/graphene');

eval(['bv0=bv',cNum,';']);
eval(['graphene=c',cNum,';']);

cd('Data');
mkdir(dataDir);
cd(dataDir);

for percent=[0.00 0.05 0.10]
    
    mkdir(num2str(percent));
    cd(num2str(percent));

    bv=[bv0([1,2],:)*(1+percent);bv0(3,:)];

    for i=1:size(atoms,1)

        mkdir(atoms{i,1});

        cd(atoms{i,1});

        %4 face body
        %T positions
        pos=graphene([100,101,108],:);
        pos=simianti(pos);
        saveFile(atoms{i,1},'1_T2',pos);
        
        pos=graphene([100,101,93],:);
        pos=simianti(pos);
        saveFile(atoms{i,1},'1_T1',pos);

        %B positions
        pos=[mean(graphene([36,101],:));mean(graphene([28,100],:));mean(graphene([35,108],:))];
        pos=simianti(pos);
        saveFile(atoms{i,1},'1_B1',pos);
        
        pos=[mean(graphene([29,101],:));mean(graphene([28,100],:));mean(graphene([36,108],:))];
        pos=simianti(pos);
        saveFile(atoms{i,1},'1_B2',pos);
        
        %H positions
        pos=[mean(graphene([35,101],:));mean(graphene([27,93],:));mean(graphene([28,94],:))];
        pos=simianti(pos);
        saveFile(atoms{i,1},'1_H',pos);
        
        
        % rectangle planar
        %H position
        pos=[mean(graphene([35,101],:));mean(graphene([27,93],:));mean(graphene([28,94],:));mean(graphene([36,102],:))];
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_H',pos);
        
        %B1 position
        pos=[mean(graphene([36,101],:));mean(graphene([28,93],:));mean(graphene([43,108],:));mean(graphene([35,100],:))];
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_B1',pos);
        
        %B2 position
        pos=[mean(graphene([29,101],:));mean(graphene([28,100],:));mean(graphene([36,108],:));mean(graphene([35,107],:))];
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_B2',pos);
        
        %B3 position
        pos=[mean(graphene([29,101],:));mean(graphene([21,93],:));mean(graphene([28,100],:));mean(graphene([20,92],:))];
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_B3',pos);
        
        %T position
        pos=graphene([100,101,93,108],:);
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_T1',pos);
        
        %T position
        pos=graphene([93,29,36,100],:);
        pos(:,3)=0.60;
        saveFile(atoms{i,1},'2_T2',pos);

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

     for ii=1:length(data) 
          fprintf(fid,'%12.6f',[data(ii,1),data(ii,2),data(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end
     
     for ii=1:length(graphene) 
          fprintf(fid,'%12.6f',[graphene(ii,1),graphene(ii,2),graphene(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end

     fclose(fid);

end

function pos=simianti(pos)
     r=meanRadius(pos,1);
     pos(:,3)=0.60;
     
     center=mean(pos);
     center(:,3)=0.60+sqrt(2)*r;
     pos=[pos;center];
end