function radius = maxRadius( pos, len)
%MAXRADIUS Summary of this function goes here
%   Detailed explanation goes here

radius = len*max(sqrt(sum((pos-ones(size(pos,1),1)*mean(pos)).^2,2)));

end

