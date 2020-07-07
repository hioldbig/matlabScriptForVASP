function data = pro60( radius )
%PRO60 Summary of this function goes here
%   Detailed explanation goes here

 angle = [0 0; pi 0];
 
 for i=1:5;
   angle=[angle;[pi/3 2*pi/5*i];[2*pi/3 pi/5+2*pi/5*i]];
 end
 
 r=2.7;
 pos=[];
 for i=1:size(angle,1)
    x= r*sin(angle(i,1))*cos(angle(i,2));
    y= r*sin(angle(i,1))*sin(angle(i,2));
    z= r*cos(angle(i,1));
    pos=[pos;[x y z]];
 end
 
 pos= pos * 1/20;
 
 combos=combntns(1:size(pos,1),2);

 data=[];
 
 for nn=1:size(combos,1)
     bian=pos(combos(nn,:)',:);
     cha=bian(2,:)-bian(1,:);
     chang=sqrt(sum(400*cha.^2,2));
     if( chang <3.2 )
        a=bian(1,:) + cha/3;
        b=a + cha/3;
        data=[data;a;b];
     end
 end
 
 data=movePOS(data,[0.5 0.5 0.5]);
 
 data=timePOS(data,radius/r);
 
end

