function c60FitFiles(n,fileID)
%���ɻ�����ϵ�����õ����ݣ�������Ŀǰ�����Ѿ�����Ĺ��͵ļ������ܣ��Լ���Ӧ��2��3��4������ϵ��������б��Թ�c60DoFit���á�
%  nΪB�ĸ���

enList=0;
yisuan=0;
compEn=0;

load(['mat/c60/enList/',num2str(n)]);
load(['mat/c60/yisuan/',num2str(n),'_1',num2str(fileID)]);
load(['mat/c60/compEn/',num2str(n),'_1',num2str(fileID)]);

fitData=zeros(size(yisuan,1),4);

fitData(:,1)=compEn(:,2);

fitData(:,2:4)=enList(yisuan,2:4);

eval(['save mat/c60/fit/',num2str(n),'_1',num2str(fileID),' fitData']);

end

