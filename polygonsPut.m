function data=polygonsPut(n,radius,dataDir,flag)
% �����Ĵ���ԭ����Ŵ����������ƶ���ָ���㣬�Ұ��մ�z�ᵽ�õ��ʸ����Ӧ�ĵ�λ��������תΪת�����������ת��
% ����1 Ŀ��������С�Ŵؽ����Ƶ���Щ���ϣ�
% ����2 Ŀ��Ǽܵĳ�ʼ�뾶
% ����3 ������ɶ���ļ��������ݽ����洢��Ŀ¼
% ����4 �Ƿ����ɶ���ļ��������Ϊ1����ֻ������һ��ʵ������ʱ����3��Ч��


global b;
global bv;
global r;
global minDis;
global maxDis;

r = radius;        % cage radius,given as the main function parameter 
b = 20;            % base vector length
bv = eye(3)*b;     % base vector for the POSCAR data
minDis = 1.7/b;   % minimum distance between two atoms
maxDis = 1.5*r/b;  % max distance between two clusters

% % ָ�������꣬�ṩ���ַ�ʽ
% % �����������㷨
    points=ballPOS2(n);
    points=timePOS(points,r/b);
    points=movePOS1(points,[0 0 0]);
% % ����

% % ��20���巽��
%     points=pro12(r);
%     points=movePOS1(points,[0 0 0]);
% % ����

% %ֱ�Ӹ����ķ�ʽ
%12
% points=[
%       0.5223610412724725  0.5688547596644657  0.5362120109833240
%       0.4276175765719266  0.5000000000000000  0.4637740424622521
%       0.4776389587275275  0.4311452403355344  0.4637879890166757
%       0.5723824234280736  0.5000000000000000  0.5362259575377475
%       0.4999757288846453  0.5000000000000000  0.5809473739853163   
%       0.5000242711153545  0.5000000000000000  0.4190526260146838   
%       0.4776389587275275  0.5688547596644657  0.4637879890166757   
%       0.4414208256012563  0.5425496802920962  0.5361915881878718   
%       0.4414208256012563  0.4574503197079041  0.5361915881878718   
%       0.5223610412724725  0.4311452403355344  0.5362120109833240   
%       0.5585791743987437  0.4574503197079041  0.4638084118121279   
%       0.5585791743987437  0.5425496802920962  0.4638084118121279
% ];

%8
% points=[
%     0.6768    0.6768    0.3232
%     0.3232    0.6768    0.3232
%     0.3232    0.3232    0.3232
%     0.6768    0.3232    0.3232
%     0.6768    0.6768    0.6768
%     0.3232    0.6768    0.6768
%     0.3232    0.3232    0.6768
%     0.6768    0.3232    0.6768
% ];

% points=timePOS(points,r/meanRadius(points,b));
% points=movePOS1(points,[0 0 0]);

%����


%�������
cd('Data');
mkdir(dataDir);
cd(dataDir);

p6=combntns(1:n,n);  %ָ��6Ԫ���ĸ���

for i=1:size(p6,1)
     array=ones(1,n)*7;   
     cp6=p6(i,:);
     array(1,cp6)=7;

     pos0=ringsLap(array,2);
     data=moveCluster(points,pos0);

     file=num2str(cp6);
     file(isspace(file)) = [];
     fid = fopen(['POSCAR',file],'w');

     atoms = {'B'};
     num = size(data,1);
     posHead(fid,atoms,num,bv);

     for ii=1:length(data) 
          fprintf(fid,'%12.6f',[data(ii,1),data(ii,2),data(ii,3)]);
          fprintf(fid,'\tT\tT\tT\n');
     end

     fclose(fid);
     
     if(flag==1) 
         break;
     end

end
    
cd ../..;

data = 'data have been saved in Files!';

end

function data=moveCluster(points,pos0)
%ת���Ŵص�ָ��λ��

global b;
global recurTimes;
global needEnlarge;
global minDis;

% z��ĵ�λʸ��
polar=[0 0 1];

data=cell(size(points,1),1);

needEnlarge = 0;  %Ĭ���Ŵ��ƶ���ָ����֮����Ҫ�Ŵ�

for i=1:size(points,1);
    
    %Ŀ����ʸ������
    point=points(i,:);
    li=sqrt(point*point');
    
    % ����i���Ŵ��Ƶ�z���ϣ�ʹ����Ŀ�����ԭ�����ͬ���ľ��룬��������תʹ�á� 
    pos=movePOS(pos0{i},[0 0 li]);
    
    % ���Ŀ����Ӧ��ʸ���ĵ�λʸ����
    point=point/li;

    % ��˵õ���ת��ʸ��
    rotate=cross(polar,point);

    % �����ת�Ƕ�
    c=acos(polar*point');

    if(norm(rotate)<0.01)
        rotate=[1 0 0];
    end

    % �Ե�i���Ŵص����������ת������¼���������
    tmp=eulerMat(c,rotate)*pos';
    tmp=tmp';
    recurTimes=0;
    [tmp,data]=comDistance(tmp,data);
    data{i}=tmp;

end

% ���հٷֱȵ���ʽ�Ŵ�Ǽܣ����Ǳ��ָ��Ŵش�С����
% ע�⣺��Ϊ�Ŵ���״���䣬������ڵ��Ŵؾ���������ܴ󣬹ʲ���ֱ�Ӱ�����ֵ������ڵľ�������Ŵ�Ǽܣ������ʵ���С��

if(needEnlarge > 0)
  tmp=cell(size(data,1),1);
  for p=1.01:0.01:1.5
     for i=1:size(data,1)
        tmp{i}=radialMove(data{i},p-1,2); 
     end
     
     if( minDistance(cell2mat(tmp),b) > minDis*b )
        data = tmp; 
        break;
     end
  end
end

data=cell2mat(data);

% %  ���ĵ�����
% center=[0 0 0];
% 
% %  �����ĵ㣬Ŀ���������ϳ�һ���ܵľ���
% data=[data;points;center];

%  �ƶ�������λ�ã�����Vesta��ʾ
data=movePOS1(data,[0.5 0.5 0.5]);

end


function  [comerN,originN]=comDistance(comer,origin)
% �жϼ�����Ŵص�ԭ�������е�ԭ�ӵľ��룬�����С���ٽ�ֵ���������ת�Ƕ�5�Σ�������������㣬��ֱ�ӷ��غ��ٷŴ�Ǽܡ�

   global minDis;
   global maxDis;
   global recurTimes;
   global needEnlarge;
   
   c_comer=mean(comer);
   phi=pi/2/size(comer,1);
   
   comerN  = comer;
   originN = origin;
   
   recurTimes = recurTimes+1;
   
   if(recurTimes > 5)   %��ת���Ŵ�5�Σ����޷�ʹ����������ԭ����ԭ�е�ԭ��֮���������򷵻ص��ú����������÷Ŵ�����Ϊ1
       needEnlarge = 1;
       return;
   end
   
   for i=1:size(origin,1)
       
       if(numel(origin{i})==0)
           continue;
       end
       
       c_origin=mean(origin{i});
       
       if(norm(c_comer-c_origin) > maxDis) 
          continue;
       else
          for j=1:size(comer,1)
               for k=1:size(origin{i},1)
                   distance = norm(comer(j,:)-origin{i}(k,:));
                   if( distance > minDis)
                       continue;
                   else
                       tmp = eulerMat(phi,c_comer)*comer';
                       tmp = tmp';
                       [comerN,originN]= comDistance(tmp,origin);
                       return;
                   end
               end
           end
       end
    end
 
end


% ŷ������
function M=eulerMat(c,rotate) 

    % �����ʸ���ļ��Ǻͷ�λ�ǣ�����䵥λʸ��
    % [sita,phi]=getPhiandSita(rotate); 
    % x=sin(sita)*cos(phi);
    % y=sin(sita)*sin(phi);
    % z=cos(sita);

    % ֱ����ʸ���Ĵ�С��ʸ����õ�λʸ��
    rotate=rotate/sqrt(sum(rotate.*rotate));
    x=rotate(1);
    y=rotate(2);
    z=rotate(3);
   
   M=[
       cos(c)+(1-cos(c))*x^2  (1-cos(c))*x*y-sin(c)*z  (1-cos(c))*x*z+sin(c)*y
       (1-cos(c))*y*x+sin(c)*z  cos(c)+(1-cos(c))*y^2    (1-cos(c))*y*z-sin(c)*x
       (1-cos(c))*z*x-sin(c)*y  (1-cos(c))*z*y+sin(c)*x   cos(c)+(1-cos(c))*z^2
    ];

end


%  ��ȡָ��ʸ���ķ�λ�Ǻͼ���
% function [sita,phi]=getPhiandSita(pos) 
%   
% x=pos(1);
% y=pos(2);
% z=pos(3);
% 
% r=sqrt(sum(pos.*pos));
% 
% sita=acos(z./r);
% phi=atan(y./x);
% 
%  if(y==0)
%     if(x>0)
%       phi=0;
%     else
%       phi=pi;
%     end
%  elseif(x<0&&y>0)
%       phi=pi+phi;
%  elseif(x<0&&y<0)
%       phi=pi+phi;
%  elseif(x>0&&y<0)
%       phi=2*pi+phi;
%  end
% 
% end
