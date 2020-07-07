function [pos,bv] = latticeCr2C(m,n,p)
%Make the POSCAR file for a hexagonal honeycomb graphene structure

 center=[0.5 0.5 0.5];
 r=3.14;
 x=[];
 y=[];
 z=[];

 bv=r*[sqrt(3)/2 1/2 0
    -sqrt(3)/2 1/2 0
 ];

 bv=[bv;[ 0 0 20]];
 
 pos=[
     sqrt(3)*r/2 0 0
     -sqrt(3)*r/2+1.84 0 1.05
     sqrt(3)*r/2-1.84 0 -1.05
 ];

%  pos=[
%      0 0 0
%      1.84 0 1.05
%      3.68 0 -1.05
%  ];

 [pos,bv]=expandCell(pos,bv,m,n,p);
 pos=movePOS1(pos,center);

 fid = fopen('./Data/POSCAR-Cr2C','w');
  
 atoms = {'C','Cr'};
 num = [1,2];
 posHead(fid,atoms,num,bv);
  
 for ii=1:size(pos,1) 
      fprintf(fid,'%12.8f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
      fprintf(fid,'\tT\tT\tT\n');
  end
  
  fclose(fid);

end

