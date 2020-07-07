function distance = getDistance( pos, len,flag)
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
  distance(distance>7)
  
  if strcmp(flag,'min')
    distance=min(distance);
  elseif strcmp(flag,'max')
    distance=max(distance);
  end
end

