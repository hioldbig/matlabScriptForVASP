function tubes(dataDir)
% 批量生成管状团簇的POSCAR文件 
% 参数为目标文件所在的文件夹，必须是当前不存在的。

bond=1.7;
L=40;
bv=eye(3)*L;

if isdir(['Data/',dataDir])
   disp 'Directory existing!';
   return;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

for i=2:1:2  %number of rings
    for j=21:1:50  % number of atoms for a ring
        r=j*bond/2/pi;
        sita=2*pi/j:2*pi/j:2*pi;
        x=r*cos(sita);
        y=r*sin(sita);
        
        pos=[];
        
        phi=0;
        
        for h=bond*sqrt(3)/2:bond*sqrt(3)/2:i*bond*sqrt(3)/2;
            z=ones(1,j)*h;
            tmp=[x' y' z'];
            phi=phi+pi/j;
            tmp=myRotate(tmp,[0 0 phi]);
            pos=[pos;tmp];
        end
        
        pos=timePOS(pos,1/L);
        pos=movePOS(pos,[0.5 0.5 0.5]);
        
        fid = fopen([num2str(i),'_',num2str(j)],'w');

        atoms = {'B'};
        num = i*j;
        posHead(fid,atoms,num,bv);

        for ii=1:length(pos) 
          fprintf(fid,'%16.12f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
        end
        
        fclose(fid);
        
        
    end
end

cd ../..

end

