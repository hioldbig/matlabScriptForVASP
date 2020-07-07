clear
close all;
a=[
% %     Li
% % -1.0337	-1.5916	-1.7271	-1.8255	-1.8949
% % -0.9354	-1.3705	-1.5322	-1.6702	-1.7907
% % -0.9308	-1.2286	-1.4052	-1.5618	-1.7011
% % -1.0994	-1.3129	-1.392	-1.4559	-1.5144


%  %Pd
-0.7343	-1.223	-1.387	-1.56	-1.7131
-1.1934	-1.5187	-1.6661	-1.8227	-1.9693
-1.4168	-1.681	-1.8243	-1.9764	-2.1235
-1.7273	-1.9089	-2.001	-2.1009	-2.1985

% % %Ti
% -0.4973	-1.3414	-1.7233	-2.1001	-2.4424
% -2.1464	-2.5846	-2.7942	-3.0068	-3.2124
% -2.7436	-3.1504	-3.3657	-3.5785	-3.7803
% -2.9252	-3.2212	-3.4189	-3.615	-3.8016



];% 0 3 5 7 9 ��Ӧ��������1��2��3��4������ԭ��
% a=a+2.5123;
nstrain=109;
nmu=1001;  %mu ����Ŀ
mua=-5; % mu������
mub=-2;   %mu������
mu=linspace(mua,mub,nmu);
num=1:1:4;
nstep=0.01;  %Ӧ���ֵ�Ĳ���
x=[ 100 103 105 107 109];
[R,C]=size(a);
for i=1:R 
    c(i,:)=spline(x,a(i,1:end),100:nstep:nstrain); 
end
c=c';
for ii=1:nmu
    for jj=1:length(100:nstep:nstrain)

        tmp=c(jj,:).*num-num*mu(ii);
        [q,qq]=min(tmp);
        re(ii,jj)=qq;
    end
end
%������ı߽磬�߽��ص��Ǹõ㲻ͬʱ�����ҵ���µ�
boundary=[ ];
hold on;
for ii=1:(length(mu)-1)
    for jj=1:(length(100:nstep:nstrain)-1)
    if re(ii,jj)==re(ii+1,jj)&&re(ii,jj)==re(ii,jj+1)
       rre(ii,jj)=0;
    else 
       rre(ii,jj)=1;
       boundary=[boundary
           jj,ii];
       plot(jj,ii,'k');
    end
    end
end
hold off;
boundaryout(:,1)=boundary(:,1)*nstep;
boundaryout(:,2)=boundary(:,2)/(nmu-1)*(mub-mua)+mua;
figure
plot(boundaryout(:,1),boundaryout(:,2),'.r');
xlabel('strain(%)');
ylabel('\mu');
% text(3,-1.5,'Li1');
% text(4,-1,'Li4');
% text(8,-1.2,'Li3');
% text(5,-1.3,'Li2');

%image(rre*20)
