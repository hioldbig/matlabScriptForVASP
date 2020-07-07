function pos = sanjiao( n )
%SANJIAO Summary of this function goes here
%   Detailed explanation goes here

center=[0.5 0.5 0.5];
r=1.7;
x=[];
y=[];
z=[];

for i=1:1:n;
    
%   if(mod(i,2)==0)
%      z0=-0.25;
%   else
%      z0=0.25;
%   end  

   z0=0;
    
  for j=1:1:2*n-i;
      
      x=[x;r*(j-1)+(i-1)*r/2];
      y=[y;(i-1)*r/2*sqrt(3)];
      z=[z;z0];
      
      if(i>1) 
          x=[x;r*(j-1)+(i-1)*r/2];
          y=[y;-(i-1)*r/2*sqrt(3)];
          z=[z;z0];
      end
      
   end
end

pos=[x y z];
pos=movePOS(pos,center);
pos=timePOS(pos,1/20);

end

