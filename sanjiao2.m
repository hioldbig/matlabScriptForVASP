function pos= sanjiao2( n )
%SANJIAO2 Summary of this function goes here
%   Detailed explanation goes here

center=[0.5 0.5 0.5];
r=1.7;
x=[0];
y=[0];
z=[0];


for i=1:n
  radius=i*r;
  sita=0:pi/(3*i):2*pi-pi/(3*i);
  
  for m=1:size(sita,2)
     x=[x;radius*cos(sita(1,m))];
     y=[y;radius*sin(sita(1,m))];
     z=[z;0];
  end
  
end

pos=[x y z];
pos=movePOS(pos,center);
pos=timePOS(pos,1/20);

end

