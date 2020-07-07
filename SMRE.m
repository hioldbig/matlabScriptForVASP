function result= SMRE( val,val0 )
% square mean root error for variables
%   

result=sqrt(sum((val-val0).^2,1)/size(val,1));

end

