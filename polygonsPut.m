function data=polygonsPut(n,radius,dataDir,flag)
% 将中心处在原点的团簇随着中心移动到指定点，且按照从z轴到该点的矢径对应的单位适量的旋转为转动矩阵进行旋转。
% 参数1 目标点个数（小团簇将被移到这些点上）
% 参数2 目标骨架的初始半径
% 参数3 如果生成多个文件，则数据将被存储的目录
% 参数4 是否生成多个文件，如果设为1，则只是生成一个实例，此时参数3无效。


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

% % 指定点坐标，提供三种方式
% % 均匀球面撒点法
    points=ballPOS2(n);
    points=timePOS(points,r/b);
    points=movePOS1(points,[0 0 0]);
% % 结束

% % 正20面体方法
%     points=pro12(r);
%     points=movePOS1(points,[0 0 0]);
% % 结束

% %直接给定的方式
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

%结束


%多个构型
cd('Data');
mkdir(dataDir);
cd(dataDir);

p6=combntns(1:n,n);  %指定6元环的个数

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
%转动团簇到指定位置

global b;
global recurTimes;
global needEnlarge;
global minDis;

% z轴的单位矢量
polar=[0 0 1];

data=cell(size(points,1),1);

needEnlarge = 0;  %默认团簇移动到指定点之后不需要放大。

for i=1:size(points,1);
    
    %目标点的矢径长度
    point=points(i,:);
    li=sqrt(point*point');
    
    % 将第i个团簇移到z轴上，使其与目标点离原点具有同样的距离，供后面旋转使用。 
    pos=movePOS(pos0{i},[0 0 li]);
    
    % 获得目标点对应的矢径的单位矢量。
    point=point/li;

    % 叉乘得到旋转轴矢量
    rotate=cross(polar,point);

    % 获得旋转角度
    c=acos(polar*point');

    if(norm(rotate)<0.01)
        rotate=[1 0 0];
    end

    % 对第i个团簇的坐标进行旋转，并记录到坐标库中
    tmp=eulerMat(c,rotate)*pos';
    tmp=tmp';
    recurTimes=0;
    [tmp,data]=comDistance(tmp,data);
    data{i}=tmp;

end

% 按照百分比的形式放大骨架，但是保持各团簇大小不变
% 注意：因为团簇形状不变，因此相邻的团簇距离会来开很大，故不能直接按照阈值与最近邻的距离比来放大骨架，比例适当调小。

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

% %  中心点坐标
% center=[0 0 0];
% 
% %  将中心点，目标点和坐标库合成一个总的矩阵
% data=[data;points;center];

%  移动到合适位置，便于Vesta显示
data=movePOS1(data,[0.5 0.5 0.5]);

end


function  [comerN,originN]=comDistance(comer,origin)
% 判断加入的团簇的原子与已有的原子的距离，如果有小于临界值，则最多旋转角度5次，如果还不能满足，则直接返回后再放大骨架。

   global minDis;
   global maxDis;
   global recurTimes;
   global needEnlarge;
   
   c_comer=mean(comer);
   phi=pi/2/size(comer,1);
   
   comerN  = comer;
   originN = origin;
   
   recurTimes = recurTimes+1;
   
   if(recurTimes > 5)   %旋转了团簇5次，都无法使得其所含的原子与原有的原子之间拉开，则返回调用函数，并设置放大条件为1
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


% 欧拉矩阵
function M=eulerMat(c,rotate) 

    % 获得轴矢量的极角和方位角，获得其单位矢量
    % [sita,phi]=getPhiandSita(rotate); 
    % x=sin(sita)*cos(phi);
    % y=sin(sita)*sin(phi);
    % z=cos(sita);

    % 直接用矢量的大小除矢量获得单位矢量
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


%  获取指定矢量的方位角和极角
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
