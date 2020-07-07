function E=c60PredictEn4SV(data,fitID)
% 获得对应结构的预测能量（针对文献的个别计算，由于拟合并没有找到这些结构，因此需要单独获取它们的ExCE energy）
% data的格式是结构向量和DFT能量构成的矩阵，具体由vasp目录下的compEn格式的数据文件给出。
% 例如：
%   1 2 14 16 17 27	-524.324580
%   1 2 16 17 22 48	-524.303230
%   1 6 16 19 21 24	-524.460360
%   
 
 E60=-531.06659;
 E59=-529.728600;         %-527.68125;   % for C59B or C59N
 E1=E59-E60;

 dirName='new/CNsystem/';

 n=size(data,2)-1;
 
 if(n < 5)
   disp 'n must be greater than 4!';
   return;
 end
 
 sv=data(:,1:n);
 Edft=data(:,n+1)-E60;

 hang=[];
 r=[];
 compEn=[];
 
 Ece=repmat([E1*n zeros(1,3)],size(sv,1),1);
 
 for ii=2:1:4
  load(['new/hang/', num2str(ii) ,'_',num2str(n),'.mat']);
  load([dirName,'fit/',num2str(ii)]);
  
  for jj=1:size(sv,1)
       no=c60SVNumberFinder(n,sv(jj,:));
       Ece(jj,ii)=sum(r(hang(no,:),:),1);
  end
  
 end
 
  load([dirName,'fit/',num2str(n),'_',num2str(fitID)]);
  
  Ece=Ece*b;
  
  E=[ Ece Edft];
  
  load([dirName,'compEn/',num2str(n),'_',num2str(fitID)]);
  Emin=min(compEn(:,2))-E60;
  E=E-Emin;
  
end

