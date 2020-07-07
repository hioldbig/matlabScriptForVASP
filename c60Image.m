function data=c60Image(n,m)
%ª≠œ‡Õº°£


if(n==2)
    imageData=zeros(23,m);
else
    imageData=zeros(303,m);
end

load('mat/c60/niheEn/4_1');
load(['mat/c60/hang/',num2str(n),'_4']);

compEn=sortrows(niheEn,2);
list=compEn(:,1);

eval(['list=hang_',num2str(n),'_4(list,:);']);
load(['mat/c60/zuoyong/', num2str(n)]);


for i=1:m
    for j=1:size(list,2)
        imageData(list(i,j),i)=imageData(list(i,j),i)+1;
    end
end

if(n==2)
   imageData=[imageData zuoyong_2];
else
%    imageData=[imageData zuoyong_3]; 
   load(['mat/c60/enList/', num2str(n)]);
   imageData=[imageData zuoyong_3+enList(:,2)]; 
end


imageData=sortrows(imageData,m+1);
imageData=imageData(:,1:m);

data=[];

if(n==2)
  for i=1:23 
    data=[data sum(imageData(:,1+(i-1)*180:i*180),2)]; 
  end
  image(data/4);
else
  for i=1:303 
    data=[data sum(imageData(:,1+(i-1)*13:i*13),2)]; 
  end
  image(data*10);
end

