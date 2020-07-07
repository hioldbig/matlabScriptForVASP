vectors=load('tmp/vector_12');

[a,hex]=c60hexagon();

hexNum=zeros(size(vectors,1),1);
areaNum=zeros(size(vectors,1),1);

for i=1:size(vectors,1)
   num=20;
   hexed=[];
   ling6=0;
   for j=1:size(hex,1)
      if intersect(vectors(i,:),hex(j,:))
          num=num-1;
      else
          hexed=[hexed;j];
      end
   end
   
   hexNum(i)=num;
   hexCell=mat2cell(hex(hexed,:),ones(1,num),6);
   [areaNum(i),~]=recurRegions(hexCell);
   
end

en=load('tmp/energy/12');

%plot(hexNum,areaNum,'red .');

%plot(en(1:30),hexNum(1:30),'red .');

kkk=unique(hexNum);

pots=zeros(size(kkk,1),1);

for i=1:size(kkk,1)
   tmp=find(hexNum==kkk(i,1));
   pots(i)=min(en(tmp,:));
end

pots=pots-min(pots);

plot(kkk,pots);

% a=[  7    13    20    23    26    34
%      9    13    18    23    25    32
%     12    15    21    24    30    36
%     26    34    38    41    47    50
%     27    31    38    42    47    53
%     29    33    39    40    48    49
%     30    36    39    43    48    54
%     40    42    49    53    55    59];
% 
% hexed=mat2cell(a,ones(1,8),6);
% 
% [num,hexed2]=recurRegions(hexed);

%将向量分区，获得分区的个数
function [num,hexed2]=recurRegions(hexed)
   
   num=size(hexed,1);
   
   
   if num < 2
      hexed2=hexed; 
      return; 
   else
      hexed2={};
      for k=1:num
        tmp=cell2mat(hexed(k,:));
        flag=0;   
        for p=1:size(hexed2,1)
          if any(ismember(hexed2{p},tmp))
             hexed2{p}=[hexed2{p} tmp];
             flag=1;
             break;
          end
        end
        
        if flag==0 
           hexed2=[hexed2;tmp];
        end 
      end
      
      if num~=size(hexed2,1)
        [num,hexed2]=recurRegions(hexed2);
      end
      
   end
   
end
