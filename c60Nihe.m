function c60Nihe(n,subs,paras,fileID)
%����c60DoFit��ȡ�����������ϲ�������ȡ���ֶ����ӵ����������ֵ������������ܣ��Թ�c60LowestList����ȡ������͵����ɸ����͡�

% nΪ�����Ŀ�������滻ԭ�Ӹ���������6
% subs�ǽ�Ҫ����Ϊ��ϵ����ϵ�е�ԭ�Ӹ���������[2,3,4]
% paras��ͨ��c60DoFit���Ȼ����ϲ���,����[0.9 0.3 0.1],���û�У�ʹ��[1 1 1]���ɡ�
%fileID�Ǵ洢��Ŀ¼niheEn�µĽ�����ļ����,����2


m=subs(length(subs));

enList=[];

eval(['load(''','mat/c60/enList/',num2str(n),''');']);

row=size(enList,1);

niheEn=zeros(row,2);

niheEn(:,1)=enList(:,1);

for j=subs
  tmp=paras(subs==j);  
  niheEn(:,2)=niheEn(:,2) + tmp*enList(:,j);
end

eval(['save mat/c60/niheEn/',num2str(n),'_1',num2str(fileID),' niheEn']);

end

