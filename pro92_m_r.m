function pro92_m_r()
%PRO92_MULTI Summary of this function goes here
%   Detailed explanation goes here

 load('mat/Ag/Ag13');
 load('mat/B/B92');
 vb=20*eye(3);
 meanR=meanRadius(B92,20);
 
 for radius=3.5:0.1:5.5
       
        
       pos=timePOS(B92,radius/meanR);

       fid = fopen(['./Data/92/',num2str(10*radius)],'w');

       atoms = {'Ag','B'};
       num = [13 92];
       posHead(fid,atoms,num,vb);

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
 
end

