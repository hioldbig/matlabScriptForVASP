function vectors=c10Bx(n)
 %最原始的计算不等价结构的程序。  

  global index;
  index=0;
  
  load('C10/index.mat');
  
  tic
  vectors=reCur(n);
  size(vectors,1)
  eval(['save C10/clist/',num2str(n),'.mat', ' vectors']);
  toc
end

function str=reCur(n) 
    if(n==1) 
        str=[1;5];
    else
        str=subFun(reCur(n-1));
    end
end

function str=subFun(str)
    
	global index;
	
	newstr=[];
	for ii=1:size(str,1)
		for jj=1:10
			if isempty(intersect(str(ii,:),jj))
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