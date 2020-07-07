function radius= meanRadius( pos, len )
%MEANRADIUS Summary of this function goes here
%   Detailed explanation goes here

radius = len*mean(sqrt(sum((pos-ones(size(pos,1),1)*mean(pos)).^2,2)));

end

