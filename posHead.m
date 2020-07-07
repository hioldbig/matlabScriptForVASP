function posHead( fid, atoms, num,bv)
%POSHEAD Summary of this function goes here
%   produce poscar file head
%   Detailed explanation goes here

  fprintf(fid,'%7s','$POSCAR');
  fprintf(fid,'%4d',size(atoms,2));
  
  for i=1:size(atoms,2)
      fprintf(fid,'%3s',atoms{i});
  end
  
  fprintf(fid,'\n');
  fprintf(fid,'%8f',1.00); 
  fprintf(fid,'\n');
  
  fprintf(fid,'%12.8f %12.8f %12.8f\n',bv'); 
  
  for i=1:size(atoms,2)
      fprintf(fid,'%s ',atoms{i});
  end
  fprintf(fid,'\n');
  
  fprintf(fid,'%4i',num);
  fprintf(fid,'\n');
  
  fprintf(fid,'%4s','Selective dynamics');
  fprintf(fid,'\n');
  
  fprintf(fid,'%4s','Direct');
  fprintf(fid,'\n');

end

