function pos = grapheneB( n )
%BGRAPHENE Summary of this function goes here
%   make the POSCAR file for a tiangle lattice for Boron
%   Detailed explanation goes here

 center=[0.5 0.5 0.5];
 r=1.7;
 x=[];
 y=[];
 z=[];

 bv=[r 0 0
    r/2 r/2*sqrt(3) 0
 ]*n;

 bv=[bv;[ 0 0 20]];

 for i=1:1:n;
    
   if(mod(i,2)==0)
     z0=-0.25;
   else
     z0=0.25;
   end  
     
   for j=1:1:n;
      
      x=[x;r*(j-1)+(i-1)*r/2];
      y=[y;(i-1)*r/2*sqrt(3)];
      z=[z;z0]; %symetry broken for relaxation
      
    end
 end

  pos=[x y z];
  pos=pos/bv;
  pos=movePOS(pos,center);

  fid = fopen('./Data/POSCAR-B-Graphene','w');
  
  atoms = {'B'};
  num = size(pos,1);
  posHead(fid,atoms,num,bv);
  
  for ii=1:length(pos) 
      fprintf(fid,'%8.4f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
      fprintf(fid,'\tT\tT\tT\n');
  end
  
  fclose(fid);

end

