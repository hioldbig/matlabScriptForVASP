function [yu, shang]=zhengshuchu(a,b)
a=uint64(a);

yu=mod(a,b);

shang=(a-yu)/b;

end