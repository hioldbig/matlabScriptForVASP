function data = pro13( radius )
%PRO13 Summary of this function goes here
%   Detailed explanation goes here

 angle = [0 0; pi 0];
 
 r=2.7;
 for i=1:5;
   angle=[angle;[pi/3 2*pi/5*i];[2*pi/3 pi/5+2*pi/5*i]];
 end
 
 pos=[];
 for i=1:size(angle,1)
    x= r*sin(angle(i,1))*cos(angle(i,2));
    y= r*sin(angle(i,1))*sin(angle(i,2));
    z= r*cos(angle(i,1));
    pos=[pos;[x y z]];
 end
 
 pos=[[0 0 0]; pos];
 
 pos=pos * 1/20;
 
 pos=movePOS(pos,[0.5 0.5 0.5]);
 
 data=timePOS(pos,radius/r);
 
end

