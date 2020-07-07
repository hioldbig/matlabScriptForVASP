function data=bCluster5(n,format)
% 生成指定向量代表的数量的5个原子的碎片

r=1.7;
b=20;
bv=eye(3)*20;
rings=[];

for i=1:n;
    sita=0:pi/3:pi;
    radius=r;
    x=radius*cos(sita);
    y=radius*sin(sita);
    z=zeros(1,4);
    
    ring=[x' y' z'];
    ring=[ring;[0 0 0]];
    rings=[rings;ring];
    
    ring=ring/bv;
    ring=movePOS(ring,[0.5 0.5 0.5]);
    cells{i}=ring;
    
end
    rings=rings/bv;
    rings=movePOS(rings,[0.5 0.5 0.5]);
   
    if(format==1)
        data=rings;
    else
        data=cells;
    end
end

