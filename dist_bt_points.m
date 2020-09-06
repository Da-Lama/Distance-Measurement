function [distance] =dist_bt_points(position)
% calculates distance between two points

for i =1:length(position)-1
    
    distance(i,1)=sqrt((position(i,1)-position(i+1,1))^2+(position(i,2)-position(i+1,2))^2);
end 
end 