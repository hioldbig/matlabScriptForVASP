function str=c60Finder(array,flag)
%find the minimal equal array from the according sites list
%if flag=1, the array is a systematic array, otherwise, it is my initial
%array.

if flag==1
str=c60Numbering(array,2);
str=c60Numbering(str,1);
else
str=c60Numbering(array,1);
str=c60Numbering(str,2);   
end


end

