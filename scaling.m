function [pixels]=scaling(A,B,C,D)

% calculates distances between A-B, C-D : A-B is axis 1, C-D is axis 2
Ax_1=sqrt((A(1,1)-B(1,1))^2+(A(1,2)-B(1,2))^2);
Ax_2=sqrt((C(1,1)-D(1,1))^2+(C(1,2)-D(1,2))^2);

pixels=mean([Ax_1 Ax_2]);
end 