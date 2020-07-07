function [c20, hex]=c60hexagon()

pos=0;
index_r=0;
load new/c60/c60.mat

hex=unique(sort(index_r(1:6,:))','rows');

c20=zeros(20,3);
for ii=1:size(hex,1)

    c20(ii,:)=mean(pos(hex(ii,:),:));
    
end

end