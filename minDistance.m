function distance = minDistance( pos, len)
%MINDISTANCE Summary of this function goes here
%   Detailed explanation goes here
  
  distance=[];
  combos=combntns(1:size(pos,1),2);
  for nn=1:size(combos,1)
     pos(combos(nn,1),:);
     tmp = sqrt(sum((pos(combos(nn,1),:)-pos(combos(nn,2),:)).^2,2));
     distance=[distance;tmp];
  end
  distance=distance*len;
  size(find(distance-2.7<0.1),1);
  distance=min(distance);
  
end

