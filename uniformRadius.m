function newPOS=uniformRadius(pos,r)
% ���Ŵصĵ�ŵ�ͳһ�İ뾶��������ȥ

b=20;
bv=eye(3)*b;

pos=movePOS(pos,[0 0 0]);
pos=pos*bv;


for i=1:size(pos,1)
     r0=norm(pos(i,:));
     d=r-r0;
     pos(i,:)=radialMove(pos(i,:),d,1);  
end
   pos=pos/bv;
   pos=movePOS1(pos,[0.5 0.5 0.5]);
   newPOS=pos;
end

