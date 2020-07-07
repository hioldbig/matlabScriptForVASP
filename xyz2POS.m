function xyz2POS(from,to)
% 将.xyz文件（例如剑桥数据库中的坐标 ）转化为POSCAR文件
% 参数1为输入的.xyz文件，参数2为输出的目标poscar文件

  pos=importdata(['./Data/',from]);
 
  [pos.textdata,idx]=sortrows(pos.textdata);
  pos.data=pos.data(idx,1:3);
 
  atomSort=unique(pos.textdata);
  atomNum=[];

  for i=1:size(atomSort,1)
    tmp=find(strcmp(pos.textdata,atomSort(i)));
    atomNum=[atomNum;size(tmp,1)];
  end
  
  bv=20*eye(3); %basic vector
  
  data=pos.data/bv;
  
  data=movePOS(data,[0.5 0.5 0.5]);

  fid = fopen(['./Data/',to],'w');
  
  fprintf(fid,'%7s','$POSCAR');
  fprintf(fid,'%4d',size(atomSort,1));
  
  for i=1:size(atomSort,1)
    fprintf(fid,'%3s',atomSort{i});
  end
  
  fprintf(fid,'\n');
  fprintf(fid,'%8f',1.00); 
  fprintf(fid,'\n');
  
  fprintf(fid,'%8.2f %8.2f %8.2f\n',bv); 
  
  for i=1:size(atomSort,1)
    fprintf(fid,'%s ',atomSort{i});
  end
  fprintf(fid,'\n');
  
  for i=1:size(atomNum,1)
    fprintf(fid,'%d ',atomNum(i));
  end
  fprintf(fid,'\n');
  
  fprintf(fid,'%4s','Selective dynamics');
  fprintf(fid,'\n');
  
  fprintf(fid,'%4s','Direct');
  fprintf(fid,'\n');
  
  for ii=1:length(data) 
      fprintf(fid,'%8.4f',[data(ii,1),data(ii,2),data(ii,3)]);
      fprintf(fid,'\tT\tT\tT\n');
  end
  
  fclose(fid);

end

