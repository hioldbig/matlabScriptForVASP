function data=ringsLap(array,format)
% 生成指定向量代表的数量的点的环，并自动将环按照一定的间隔叠起来，形成旋转对称的但半径不断改变的管子
% 参数形如 [5 7 6 9 10],则自上而下，分辨将5个，7个，6个，9个，10个原子坐标构成的正多边形叠起来。

r=1.7;
b=20;
rings=[];
cells=cell(numel(array),1);

for i=1:numel(array);
    sita=2*pi/array(i):2*pi/array(i):2*pi;
    radius=r/2/sin(pi/array(i));
    x=radius*cos(sita);
    y=radius*sin(sita);
    z=ones(1,array(i))*i*r*sqrt(3)/2;
    
    ring=[x' y' z'];
    rings=[rings;ring];
    
    ring=timePOS(ring,1/b);
    ring=movePOS(ring,[0.5 0.5 0.5]);
    cells{i}=ring;
    
end
    rings=timePOS(rings,1/b);
    rings=movePOS(rings,[0.5 0.5 0.5]);
   
    if(format==1)
        data=rings;
    else
        data=cells;
    end
end

