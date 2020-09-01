function [time_diff]=time_substraction(time1,time2)

% this function substracts time: hours, minutes, seconds
% input:
%      time2: later times : eg 2:45:30
%      time1: earlier times:eg 2:15:15
% output:
%      time_diff: difference in time (seconds)
%      temp_time: matrix of difference in time(coloums:- 1: hour, 2: minutes, 3: seconds)

temp_time=time2-time1;

if temp_time(2)<0
    temp_time(2)=temp_time(2)+60;
    temp_time(1)=temp_time(1)-1;
end
if temp_time(3)<0
    temp_time(3)=temp_time(3)+60;
    temp_time(2)=temp_time(2)-1;
end

temp_time(1)=temp_time(1)*3600;
temp_time(2)=temp_time(2)*60;
temp_time(3)=temp_time(3)*1;
time_diff=sum(temp_time);

end