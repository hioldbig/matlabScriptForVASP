function a= splitNums( n,k )
 if(k==1)
     a=n;
  else    
     a=zeros(size(n,1),k);  
     for i=2:k
         tmp=floor(n/(100^(k-i+1)));
         n=mod(n,100^(k-i+1));
         a(:,i-1)=tmp;
     end
     a(:,end)=n;
  end
end

