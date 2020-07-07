function data = myRotate( data,direct)
% rotate the coordinates of the cluster about its center
% data is the init coordinates
% direct is the angle matrix for rotation
% direct is a matrix, for example [alpha beta gamma] where alpha is the 
% angle around x-axis, beta and gamma for y and z respectively
 
if(numel(direct)>0) 
     sita=direct(1);
 else
     sita=0;
 end

 param_x = [
   1 0 0
   0 cos(sita) sin(sita)
   0 -sin(sita) cos(sita)
 ];

 if(numel(direct)>1) 
     sita=direct(2);
 else
     sita=0;
 end

 param_y = [
    cos(sita) 0 -sin(sita)
    0 1 0
    sin(sita) 0 cos(sita)
 ];

 if(numel(direct)>2) 
     sita=direct(3);
 else
     sita=0;
 end

 param_z = [
    cos(sita) sin(sita) 0
    -sin(sita) cos(sita) 0
    0 0 1
 ];

 center=mean(data);

 data=movePOS(data,[0 0 0]);
 data=data';
 data= param_z*param_y*param_x*data;
 data=data';

 data=movePOS(data,center);
 
end

