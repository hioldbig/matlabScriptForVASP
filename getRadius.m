function radius = getRadius( pos, len,flag)
%MAXRADIUS Summary of this function goes here
%   Detailed explanation goes here
if strcmp(flag, 'min')
    radius = len*min(sqrt(sum((pos-ones(size(pos,1),1)*mean(pos)).^2,2)));
elseif strcmp(flag, 'max')
    radius = len*max(sqrt(sum((pos-ones(size(pos,1),1)*mean(pos)).^2,2)));
elseif strcmp(flag , 'mean')
    radius = len*mean(sqrt(sum((pos-ones(size(pos,1),1)*mean(pos)).^2,2)));
end

