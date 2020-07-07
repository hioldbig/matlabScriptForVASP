function newPOS= changeBv( oldPOS,oldBv,bv)
%CHANGEBV Summary of this function goes here
%   Detailed explanation goes here

oldPOS=oldPOS*oldBv;

cha=[0.5 0.5 0.5]*bv-[0.5 0.5 0.5]*oldBv;

for i=1:1:3;
    oldPOS(:,i)= oldPOS(:,i)+cha(:,i);
end;  
    newPOS = oldPOS/bv;
end

