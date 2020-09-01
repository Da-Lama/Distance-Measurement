function [angle]=fishAngle(H_position, C_position, Ref_point)

% Angle calculation,
P0 = [C_position(1,1), C_position(1,2)];
P1 = [Ref_point(1,1), Ref_point(1,2)];
P2 = [H_position(1,1), H_position(1,2)];

n1(1,:) = [P2(1,1)-P0(1,1),P2(1,2)-P0(1,2)];  
n2(1,:)= [P1(1,1)-P0(1,1),P1(1,2)-P0(1,2)];
angle=atan2d((det([n1(1,:);n2(1,:)])),dot(n1(1,:),n2(1,:)));
end