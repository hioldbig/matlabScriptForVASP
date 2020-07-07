function pos= sanjiao3(n)
% 一种奇异的三角晶格碎片的程序
% 暂时无用

r0=1.7;
pos=[0 0 0];
fens=[6 13];
for i=1:1:n
  r=r0*i;
  fen=i*3+floor(rand()*3);
%   fen=fens(i);
  sita=2*pi/fen:2*pi/fen:2*pi;
  x=r*cos(sita);
  y=r*sin(sita);
  z=zeros(1,fen);
  tmp=[x' y' z'];
  pos=[pos;tmp];
end
  pos=timePOS(pos,1/20);
  pos=movePOS(pos,[0.5 0.5 0.5]);
end

