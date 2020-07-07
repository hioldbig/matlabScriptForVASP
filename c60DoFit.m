function paras=c60DoFit(n,fileID)
% ���Ѿ�������������ݲ��ö�Ӧ�Ĺ��͵���������ܳ���3���仯�Ĳ�������������ϣ�ѡ����С����������Ӧ�����ϵ����
% nΪB�ĸ���
% fileIDΪfitĿ¼��ĳ���ļ���ID
  
  fitData=[];
  paras=[];
  
  load(['mat/c60/fit/',num2str(n),'_1',num2str(fileID)]);
  load(['mat/c60/paras/',num2str(n),'_1']);
  
  fitData(:,1)=fitData(:,1)+531.06659-n*3.38534;

%   error=[];
% 
%   for a=0:0.01:1
%         for b=0:0.01:1
%             for c=0:0.01:1
%                  tmp=a*fitData(:,2)+b*fitData(:,3)+c*fitData(:,4);
%                  error=[error;[a b c SMRE(tmp,fitData(:,1))]];
%             end
%         end
%    end
% 
%    error=sortrows(error,4);
   
   X=n*3.38534;
   Y=fitData(:,1)+X;
   X=ones(size(Y,1),1)*X;
   X=[X fitData(:,2:4)];

   [b, bint, r, rint, stats] = regress(Y,X); 
   error=sqrt(sum(r.^2,1)/size(r,1));
   error=[b' error]
   
   
% paras=[paras;error(1,:)];
% eval(['save mat/c60/paras/',num2str(n),'_1  paras']);
  
end

