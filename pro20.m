function data = pro20( radius)
%PRO20 Summary of this function goes here
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
  
 two=[];
 combos=combntns(1:size(pos,1),2);
 for nn=1:size(combos,1)
     tmp = sqrt(sum((pos(combos(nn,1),:)-pos(combos(nn,2),:)).^2,2));
     if(abs(r-tmp) > 1)
         continue;
     end
     two=[two;combos(nn,:)];
 end
 
 size(two,1);
  
 three=[];
 
 for nn=1:size(two,1)
     
     selected = pos(two(nn,:)',:);
     rested = setdiff(pos,selected,'rows');
     
     for mm=1:size(rested,1)
        tmp1 = sqrt(sum((rested(mm,:)-selected(1,:)).^2,2));
        tmp2 = sqrt(sum((rested(mm,:)-selected(2,:)).^2,2));
        
        if(abs(tmp1-r)>1 || abs(tmp2-r)>1)
          continue;
        end
        
        tmp =  (rested(mm,:) +  selected(1,:)  + selected(2,:))/3;
        
        three=[three;tmp];
        
     end
 end
 
 three=roundn(three,-6);
 data = unique(three,'rows');
 
 data=data * 1/20;
 
 data=movePOS(data,[0.5 0.5 0.5]);
 
 data=timePOS(data,radius/r);
 
end

