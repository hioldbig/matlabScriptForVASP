function str=c60Bx(n)
 %最原始的计算不等价结构的程序。  

  global index;
  
  load('mat/c60/c60');
  
  index=index_r;
  tic
  str=reCur(n);
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
		for jj=1:60
			if length(intersect(str(ii,:),jj))==0
				tp=[str(ii,:) jj]';
				
                %begin-----amended by chengyh
                tmp=index(tp,:);
                %tmp=sort(tmp); %if replaced as the same atoms, this do, otherwise, don't do it!
                tmp=unique(tmp','rows');
                %end------amended by chengyh
				
%                 %begin----origin by yang
%                 tmp=index(tp,:)';
%                 for kk=1:size(tmp,1)
% 					tmp(kk,:)=sort(tmp(kk,:));
% 				end
% 				tmp=unique(tmp,'rows');
%                 %end------origin by yang
                
				newstr=[newstr
				   tmp(1,:)];
			end
		end
	end
	str=unique(newstr,'rows');

end