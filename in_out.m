function [Dist2cent, diffs_cent]= in_out(C_position, Ref_point)
len=size(C_position);
for i=1:len(1)
Dist2cent(i)=sqrt((C_position(i,1)-Ref_point(1,1))^2+(C_position(i,2)-Ref_point(1,2))^2);
end 
diffs_cent=diff(Dist2cent);


end 