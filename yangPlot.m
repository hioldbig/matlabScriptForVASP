clear;
close all;
pos=importdata('plot/yangData');
[pos.textdata,idx]=sortrows(pos.textdata);

atomSort=unique(pos.textdata);

mu=-4:1:-1;

ploti=1;
for i=1:size(atomSort,1)
    tmp=find(strcmp(pos.textdata,atomSort(i)));
    data=pos.data(tmp,:);
    
    yingli=unique(data(:,1));
    
    for j=1:size(yingli,1)
      
      tmp=[];
      for k=1:size(data)
         if(data(k,1)==yingli(j))
             tmp=[tmp;data(k,2:3)];   
          end
      end
      
      if(size(tmp,1))
      
          subplot(4,6,ploti);
          ploti=ploti+1;
      
          for k=1:size(tmp,1)
           x=mu;
           y=tmp(k,2)*tmp(k,1)-mu*tmp(k,1);
           title([atomSort(i),yingli(j)]);

           xlabel('mu');
           ylabel('Ed-N*mu');

           plot(x,y,'b');
           hold on;

          end

          hold off;
          
      end
       
    end
    
end


