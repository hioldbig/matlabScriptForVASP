function [pos,bv] = grapheneC(m,n,p)
%Make the POSCAR file for a hexagonal honeycomb graphene structure

 center=[0.5 0.5 0.5];
 r=1.42;
 x=[];
 y=[];
 z=[];

 bv=[3*r/2 r*sqrt(3)/2 0
    -3*r/2 r*sqrt(3)/2 0
 ];

 bv=[bv;[ 0 0 20]];
 
 pos=[
     -1/2 0 0
     1/2 0 0
 ]*r;

 [pos,bv]=expandCell(pos,bv,m,n,p);
 pos=movePOS1(pos,center);

 fid = fopen('./Data/POSCAR-C-Graphene','w');
  
 atoms = {'C'};
 num = size(pos,1);
 posHead(fid,atoms,num,bv);
  
 for ii=1:size(pos,1) 
      fprintf(fid,'%12.8f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
      fprintf(fid,'\tT\tT\tT\n');
  end
  
  fclose(fid);

end

