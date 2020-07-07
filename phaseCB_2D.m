
clear

a1=[
  -531.066590 
  -527.681250
  -525.059070
  -521.919880
  -519.159310
  -516.283380
  -513.072830
];

a2=0:1:6;
a3=60-a2;

a=[a1 a2' a3'];

uc=linspace(-10,0,1001);
ub=uc;

for ii=1:length(uc)
    for jj=1:length(ub)
        e=a(:,1)-a(:,2)*ub(ii)-a(:,3)*uc(jj);
        [q,qq]=min(e);
        phase(ii,jj)=qq;
    end
end

image(phase*8)