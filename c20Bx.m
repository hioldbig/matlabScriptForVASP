function vectors=c20Bx(n)
 %最原始的计算不等价结构的程序。  

  global index;
  index=0;
  
  load('C20/index.mat');
  
  tic
  vectors=reCur(n);
  size(vectors,1)
  eval(['save C20/clist/',num2str(n),'.mat', ' vectors']);
  toc
end

function str=reCur(n) 
    if(n==1) 
        str=1;
    else
        str=subFun(reCur(n-1));
    end
end

function str=subFun(str)
    
	global index;
	
	newstr=[];
	for ii=1:size(str,1)
		for jj=1:20
			if length(intersect(str(ii,:),jj))==0
				tp=[str(ii,:) jj]';
				tmp=index(tp,:)';
				for kk=1:size(tmp,1)
					tmp(kk,:)=sort(tmp(kk,:));
				end
				 tmp=unique(tmp,'rows');
				newstr=[newstr
				   tmp(1,:)];
			end
		end
	end
	str=unique(newstr,'rows');

end