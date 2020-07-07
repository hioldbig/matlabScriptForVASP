function c60NewSubList(n,flag)
% Total of equal sites for different number of substitutions on C60 cluster
% n is the number of boron atoms
% for n=6  time used is 45s
% for n=9  time used is 24242s
% for n=10 time used is 158560s

 index=load('new/c60/index.txt');

 try
   load(['new/c60/clist/',num2str(n)]);
   disp(['C',num2str(60-n),'B',num2str(n),' has been accomplished!']);
   return;
 catch
   disp(['C',num2str(60-n),'B',num2str(n),' is to be calculated...']);
 end
 
 init=2;
 list1=1;
 
 for ii=n-1:-1:1
   beishu=61.^(ii-1:-1:0)'; %beishu(1)=0; 
   if exist(['new/c60/clist/',num2str(ii),'.mat'], 'file')
      load(['new/c60/clist/',num2str(ii)]);
      list1=double(list1)*beishu;  % Coz the data saved are of single type!
      init=ii+1;
      break;
   else
      disp(['warning：no data for ',num2str(ii),' found!']); 
   end
 end

 list2=list1;
 
 tic;
 for ii=init:n 
    beishu=61.^(ii-1:-1:0)'; %beishu(1)=0;
    list1=tmpFun(list2,ii-1);
%     list1=tmpFun(list2,ii-2);
%     list1=[ones(size(list1,1),1) list1];
    km=61-ii;
    jm=size(list1,1);
    
    if(flag==1) 
     %两层循环计算最节省内存   
        list2=zeros(jm,km,'double');
        parfor j=1:jm
           diffNum=setdiff(index(:,1)',list1(j,:));
           for k=1:km
                toFind=sort(index([list1(j,:) diffNum(k)],:))';
                toFind=toFind(toFind(:,1)==1,:);
                list2(j,k)=min(toFind*beishu);
           end
        end
        list2=unique(list2);
    
    elseif(flag==2) 
     %两层循环计算,这个算法在采用丢弃首位的方式时，会产生错误，结果偏小。
        list2=zeros(120,jm*km,'double');  %这一步会导致较大内存开销
        for j=1:jm
           diffNum=setdiff(index(:,1)',list1(j,:));
           for k=1:km
                toFind=[list1(j,:) diffNum(k)];
                list2(:,(j-1)*km+k)=sort(index(toFind,:))'*beishu;
           end
        end
        list2=unique(min(list2)');
    
    else 
    
        list3=repmat((0:jm-1)*60,ii-1,1)+list1';
        c60=zeros(60,jm,'double'); 
        c60(list3)=list3;
        c60=c60-repmat((0:jm-1)*60,60,1);
        c60(c60<0)=0;
        c60=repmat((1:60)',1,jm)-c60;
        c60(c60==0)=[];
        c60=reshape(c60,km,[]);
        c60=c60';

        list1=repmat(list1,1,1,km);
        list1(:,ii,:)=c60;
        list1=reshape(list1,jm*km,ii);

       if(flag==3)
        %单层循环计算
        list2=zeros(120,jm*km,'double');
        for j=1:jm*km 
           list2(:,j)=sort(index(list1(j,:),:))'*beishu;
        end
        list2=unique(min(list2)');

       else 
        %采用bxsfun向量化计算   
         list2=sort(reshape(index(list1',:)',120,ii,jm*km),2);
         list2=sum(bsxfun(@times,list2,permute(repmat(beishu,1,1,jm*km),[2 1 3])),2);
         list2=unique(min(reshape(list2,120,[]))');

       end
   
    end
   
 end
 toc;
 
 list1=single(tmpFun(list2,n));  %Saving in single type makes the data much more smaller.
%  list1=tmpFun(list2,n-1);
%  list1=[ones(size(list1,1),1) list1];
 size(list1,1)
eval(['save new/c60/clist/',num2str(n), ' -v7.3 list1']);
 
end

function a=tmpFun(n,k)
  if(k<2)
      a=n;
  else    
      a(size(n,1),k)=0;  
      for i=2:k
         tmp=floor(n/(61^(k-i+1)));
         n=mod(n,61^(k-i+1));
         a(:,i-1)=tmp;
      end
      a(:,end)=n;
  end
end