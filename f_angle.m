
function [angle]=f_angle(H_position,C_position,T_position)
%The shown code calculates the angle between the lines from P0 to P1 and P0 to P2.
% po=c_position
% p1=h_position
% p2=t_position
P0 = [C_position(1,1), C_position(1,2)];
P1 = [H_position(1,1), H_position(1,2)];
P2 = [T_position(1,1), T_position(1,2)];
n1 = (P2 - P0) / norm(P2 - P0);  % Normalized vectors
n2 = (P1 - P0) / norm(P1 - P0);
% angle1 = acos(dot(n1, n2));                        % Instable at (anti-)parallel n1 and n2
% angle2 = asin(norm(cross(n1, n2)));                % Instable at perpendiculare n1 and n2
% angle3 = atan2(norm(cross(n1, n2)), dot(n1, n2)); 
angle = atan2((det([P2-P0;P1-P0])),dot(P2-P0,P1-P0));% Stable
end 