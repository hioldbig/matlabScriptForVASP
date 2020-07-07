% ��һ����������N���㣬ʹ������ȷֲ���������
% ����Ϊ��ĸ���
% ���������Nx3����

function rn=ballPOS2(N)
a=rand(N,1)*2*pi;%�������������ȷֲ���������һ����ʼ״̬
b=asin(rand(N,1)*2-1);
r0=[cos(a).*cos(b),sin(a).*cos(b),sin(b)];
v0=zeros(size(r0));
G=1e-2;%�����������������ֵ�Ƚϲ���
for ii=1:5000 %ģ��200����һ���Ѿ���������ʵ������֮���˳�
    [rn,vn]=countnext(r0,v0,G);%����״̬
    r0=rn;v0=vn;
end

% plot3(rn(:,1),rn(:,2),rn(:,3),'.');hold on;%�����
% [xx,yy,zz]=sphere(50);
% h2=surf(xx,yy,zz); %��һ����λ�����ο�
% set(h2,'edgecolor','none','facecolor','r','facealpha',0.7);
% axis equal;
% axis([-1 1 -1 1 -1 1]);
% hold off;

end

function [rn,vn]=countnext(r,v,G) %����״̬�ĺ���
%r���ÿ���x��y��z���ݣ�v���ÿ����ٶ�����
num=size(r,1);
dd=zeros(3,num,num); %������ʸ����
for m=1:num-1
    for n=m+1:num
        dd(:,m,n)=(r(m,:)-r(n,:))';
        dd(:,n,m)=-dd(:,m,n);
    end
end
L=sqrt(sum(dd.^2,1));%�����ľ���
L(L<1e-2)=1e-2; %�����С�޶�
F=sum(dd./repmat(L.^3,[3 1 1]),3)';%�������

Fr=r.*repmat(dot(F,r,2),[1 3]); %��������������
Fv=F-Fr; %�������

rn=r+v;  %��������
rn=rn./repmat(sqrt(sum(rn.^2,2)),[1 3]);
vn=v+G*Fv;%�����ٶ�
end

