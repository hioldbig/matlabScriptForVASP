function [pos,bv]= expandCell( pos,bv,m,n,p )
% Expand a unit cell of pos 
% pos is the primative cell matrix data
% m is the expanding times along x axis, and n and p are for y and z respectively. 
% bv is the lattice vector of unit cell
% this script does not work if there are more than one type of atoms.

% expand alang a
 data=cell(m,1);
 for i=0:m-1
      for k=1:size(pos,1)
          data{i+1}(k,:)=pos(k,:)+i*bv(1,:);
      end
 end
 pos=cell2mat(data);
 
 % expand alang b
 data=cell(n,1);
 for i=0:n-1
      for k=1:size(pos,1)
         data{i+1}(k,:)=pos(k,:)+i*bv(2,:);
      end
 end
 pos=cell2mat(data);
 
 % expand alang c
 data=cell(p,1);
 for i=0:p-1
      for k=1:size(pos,1)
         data{i+1}(k,:)=pos(k,:)+i*bv(3,:);
      end
 end
 pos=cell2mat(data);
 
 
 bv=[
     m 0 0; 
     0 n 0; 
     0 0 p
 ]*bv;
 
 pos=pos/bv;

end

