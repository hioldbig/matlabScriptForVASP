function list1=cr2CSubList(n)
% Total of equal sites for different number of substitutions on Cr2C
% lattice
% n is the number of magmom=-1
  
 load('Cr2C/index');
 index=index_4x4;
 index=index(17:end,:)-16;
 
 list1=1;
 list2=list1;
 tic;
 for i=2:n
    times=33.^(i-1:-1:0)';
    list1=tmpFun(list2,i-1);
    km=19-i;
    jm=size(list1,1);
    list2=zeros(64,jm*km,'double');
    for j=1:jm
       diffNum=setdiff(index(:,1)',list1(j,:));
       for k=1:km
            toFind=[list1(j,:) diffNum(k)];
            list2(:,(j-1)*km+k)=sort(index(toFind,:))'*times;
       end
    end
    list2=unique(min(list2)');
 end
 
 list1=tmpFun(list2,n);
 size(list1,1)
 eval(['save Cr2C/clist4x4/',num2str(n), ' list1']);

 toc;
end

function a=tmpFun(n,k)
  if(k==1)
      a=n;
  else    
      a(size(n,1),k)=0;  
      for i=2:k
         tmp=floor(n/(33^(k-i+1)));
         n=mod(n,33^(k-i+1));
         a(:,i-1)=tmp;
      end
      a(:,end)=n;
  end
end