function c60SubPOSCAR(dataDir,n,myList,flag)
% To produce the POSCAR files for all substituted cases of n B atoms on C60
% dataDir is the target directory,and n is the number of B atoms
% myList 是需要生成POSCAR的构型对应的行号

%pre-define the vars
list1=[];
pos=[];

load('new/c60/c60');  % get pos of relaxed C60

if flag==1
  load(['new/c60/clist/',num2str(n)]);  
  subList=list1(myList,:);
else
  subList=myList;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

for i=1:size(subList,1)
    tmp=pos;
    site=subList(i,:);
    %sub=pos(subList(i,:),:);  % setdiff is not fit here!
    sub=tmp(subList(i,:),:);
    tmp(subList(i,:),:)=[];
    % tmp=setdiff(pos,sub,'rows');  setdiff will change the default order!!
    data=[sub;tmp];
    
    saveFile(n,site,data);
    
end

cd ../..

end

function saveFile(n,site,data)
     
     bv=eye(3)*20;
     site=num2str(site);
     site(isspace(site)) = '_';
     site=strrep(site,'__','_');
     
     fid = fopen(['POSCAR_',site],'w');

     atoms = {'N','C'};
     num = [n 60-n];
     posHead(fid,atoms,num,bv);

     for ii=1:length(data) 
          fprintf(fid,'%21.16f',[data(ii,1),data(ii,2),data(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end

     fclose(fid);

end

