function multiBall(dataDir,n,m)
%MULTIBALL Summary of this function goes here
%   Detailed explanation goes here

bv=26*eye(3); 
oldBv=20*eye(3);

if isdir(dataDir)
   disp 'Directory existing!';
   return;
end

cd('Data');
mkdir(dataDir);
cd(dataDir);

for r=2.8:0.1:3.8
    
    mkdir(num2str(r));
    cd(num2str(r))

    for i=1:1:m

            pos=ballPOS2(n);
            
%             for j=1:1:10;
%               kongwei=floor(rand(1,6)*46);
%               kongwei(kongwei==0)=1;
%               if(numel(unique(kongwei),1)==6) 
%                   break;
%               end;
%             end;
%             
%             pos(kongwei,:)=[];
            
            pos=timePOS(pos,r/20);
            pos=movePOS1(pos,[0.5 0.5 0.5]);

            fid = fopen(num2str(i),'w');

            atoms = {'B'};
            num = size(pos,1);
            posHead(fid,atoms,num,oldBv);

    %         pos=changeBv(pos,oldBv,bv);

            for ii=1:length(pos) 
                fprintf(fid,'%8.4f',[pos(ii,1),pos(ii,2),pos(ii,3)]);
                fprintf(fid,'\tT\tT\tT\n');
            end

            fclose(fid);

    end
    
    cd ..

end

cd ../..

end
