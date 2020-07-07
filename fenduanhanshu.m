
% 画出分段函数
%  当x<=-7时：y=(x-2)(x+5)； 当-7<x<=8时 y=(8-x)(7+x); 当x>8时，y=(x-2)(x+5)
%  在[-100，100]内的图

x=-20:1:20;
y=x;
for i=1:size(x,2)
   if x(i)<=-7
       y(i)=(x(i)-2)*(x(i)+5);
   elseif x(i)<=8
       y(i)=(x(i)+7)*(8-x(i));
   else
       y(i)=(x(i)-2)*(x(i)+5);
   end
end

plot(x,y)


