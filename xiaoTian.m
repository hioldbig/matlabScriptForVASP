% 小天的一个程序，生成二十面体的团簇，做参考
clear
fclose('all');


T=[cos(pi/3) sin(pi/3);-sin(pi/3) cos(pi/3)];
T1=[cos(pi/6) sin(pi/6);-sin(pi/6) cos(pi/6)];



S1=[3.07 0];
for I=1:5
    S1=[S1;S1(1,:)*T^I];
end
S1=[0 0;S1];
S2=S1*T1;



S=[S1 zeros(7,1);S2 2.6*ones(7,1);S1 5.2*ones(7,1);S2 7.8*ones(7,1)];
S([1 8 15 22],3)=S([1 8 15 22],3)+0.1;



A=20;
B=20;
C=20;

fid=fopen('./Data/xiaotian-POSCAR','w');
    fprintf(fid,'%s','$POSCAR   1  Mg');
    fprintf(fid,'\n');
    fprintf(fid,'%10.4f',1); 
    fprintf(fid,'\n');
    fprintf(fid,'%10.4f',[A 0 0]);
    fprintf(fid,'\n');
    fprintf(fid,'%10.4f',[0 B 0]);
    fprintf(fid,'\n');
    fprintf(fid,'%10.4f',[0 0 C]);
    fprintf(fid,'\n');
    fprintf(fid,'%4i',size(S,1));
    fprintf(fid,'\n');
    fprintf(fid,'%s','Selective dynamics');
    fprintf(fid,'\n');
    fprintf(fid,'%s','Direct');
    fprintf(fid,'\n');
    for I=1:size(S,1)
        fprintf(fid,'%10.4f',[S(I,1)/A+0.5 S(I,2)/B+0.5 S(I,3)/C+0.5]);
        fprintf(fid,'%4s','T');
        fprintf(fid,'%4s','T');
        fprintf(fid,'%4s','T');
        fprintf(fid,'\n');
    end
fclose(fid);