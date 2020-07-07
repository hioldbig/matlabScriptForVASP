function c60SubList(n)
% Total of in-equal sites for different number of substitutions on C60 cluster
% n is the number of substituted atoms
% 此程序有新版本，即c60NewSubList

 index=load('new/c60/index.txt');
 list1=1;
 list2=list1;
 tic;
 for i=2:n
    times=61.^(i-1:-1:0)';
    list1=tmpFun(list2,i-1);
    km=61-i;
    jm=size(list1,1);
    
    list2=zeros(120,jm*km,'double');
    for j=1:jm
        diffNum=setdiff(index(:,1)',list1(j,:));
        for k=1:km
             toFind=[list1(j,:) diffNum(k)];
             list2(:,(j-1)*km+k)=sort(index(toFind,:))'*times;
       end
    end
    list2=unique(min(list2)');
    
 end
 list1=list2;
 size(list1,1)
 toc;
end

function a=tmpFun(n,k)
  if(k==1)
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