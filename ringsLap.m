function data=ringsLap(array,format)
% ����ָ����������������ĵ�Ļ������Զ���������һ���ļ�����������γ���ת�ԳƵĵ��뾶���ϸı�Ĺ���
% �������� [5 7 6 9 10],�����϶��£��ֱ潫5����7����6����9����10��ԭ�����깹�ɵ�������ε�������

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

