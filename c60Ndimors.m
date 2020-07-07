function data=c60Ndimors(n)
% 找到所有非等价的由n个dimors of Nitrigon组成的结构

vectors=[];
hex=[];
beishu=[61;1];

load new/c60/index.mat
index60=index;

load C20/hex.mat
eval(['load C20/clist/', num2str(n),'.mat']);

dimors=unique(sort(index60([1,6],:))','rows');     %对位集合
dimorsNum=dimors*beishu;

neighbours=unique(sort([index60([1,3],:) index60([1,5],:)])','rows'); %近邻集合

rows=size(vectors,1);
cols=size(vectors,2);

data=cell(rows,1);

for ii=1:rows
    aa=zeros(3,cols);
    for jj=1:cols
        tmp=nchoosek(hex(vectors(ii,jj),:),2)*beishu;
        aa(:,jj)=intersect(tmp,dimorsNum);
    end
    
    tmp=zeros(3^cols,cols);
    
%     for jj1=1:3
%         for jj2=1:3
%             tmp((jj1-1)*3+jj2,:)=[aa(jj1,1) aa(jj2,2)];
%         end
%     end
%     
%     for jj1=1:3
%         for jj2=1:3
%             for jj3=1:3
%                tmp((jj1-1)*9+(jj2-1)*3+jj3,:)=[aa(jj1,1) aa(jj2,2) aa(jj3,3)];  
%             end
%         end
%     end
    
    for jj1=1:3
        for jj2=1:3
            for jj3=1:3
                for jj4=1:3
                   tmp((jj1-1)*27+(jj2-1)*9+(jj3-1)*3+jj4,:)=[aa(jj1,1) aa(jj2,2) aa(jj3,3) aa(jj4,4)];  
                end
            end
        end
    end
    
    data{ii}=tmp;
    
end

data=cell2mat(data);

data=reshape(data',[],1);

data=tmpFun(data,2);

data=sort(reshape(data',2*cols,[]))';

for ii=1:size(data,1)      % 将那些含有近邻的结构都设置为零，为删除做准备
  for jj=1:size(neighbours,1)
     tmp=intersect(data(ii,:),neighbours(jj,:));
     if size(tmp,2)==2
        data(ii,:)=zeros(1,2*cols);
        break;
     end
  end
end

for ii=1:size(data,1)       %将那些六元环上多于2个被替换的结构都设置为零，为删除做准备
   occupied=zeros(20,1);
   
   for jj=1:size(data,2)
      [hang,~]=find(hex==data(ii,jj));
      occupied(hang)=occupied(hang)+1;
   end
   
   if(find(occupied>2)) 
      data(ii,:)=zeros(1,2*cols);    
   end
   
end

for ii=1:size(data,1)       %将具有其他重复元素的行的元素位置也标记为零
   if ~isequal(unique(data(ii,:)),data(ii,:))
       data(ii,:)=zeros(1,2*cols);   
   end
end

data(all(data == 0, 2),:)=[];  %去掉上述设置的零行

for ii=1:size(data,1)     %对照C60的结构，得到等价结构
    data(ii,:)=c60Finder(data(ii,:));
end

data=unique(data,'rows');  %去重得到不等价结构

end

function a=tmpFun(n,k) 

  if(k<2)
      a=n;
  else    
      a(size(n,1),k)=0;  
      for i=2:k
         
         yu=mod(n,61^(k-i+1));
         tmp=(n-yu)/(61^(k-i+1));

         n=yu;
         a(:,i-1)=tmp;
      end
      a(:,end)=n;
  end
  
  a=uint8(a); 

end