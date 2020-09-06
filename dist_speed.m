%% Distance measurement
figure
imshow(ct_im)
hold on
distance=[];
al=0;
clear position
for i=1:length(S_frames)%[1:5,9:11]%1:length(S_frames)
    
    if i==1
        if fr_no(i,1)>fr_nu(i,1)
            position=[c_Position(1:fr_nu(i,1),1),c_Position(1:fr_nu(i,1),2)];
            distance(:,i)=dist_bt_points(position);
            
            scatter(position(1:end-1,1),position(1:end-1,2),20,distance(:,i)/30,'filled')
        elseif fr_no(i,1)<=fr_nu(i,1)
            
            position=[c_Position(1:fr_no(i,1),1),c_Position(1:fr_no(i,1),2)];
            distance(:,i)=dist_bt_points(position);
            scatter(position(1:end-1,1),position(1:end-1,2),20,distance(:,i)/30,'filled')
            
        end
        
        al=al+2;
    else
        
        if fr_no(i,1)>fr_nu(i,1)
            
            position=[c_Position(1:fr_nu(i,1),al+1),c_Position(1:fr_nu(i,1),al+2)];
            distance(1:length(position)-1,i)=dist_bt_points(position);
            scatter(position(1:end-1,1),position(1:end-1,2),20,distance(1:length(position)-1,i)/30,'filled')
            
        elseif fr_no(i,1)<=fr_nu(i,1)
            
            position=[c_Position(1:fr_no(i,1),al+1),c_Position(1:fr_no(i,1),al+2)];
            distance(1:length(position)-1,i)=dist_bt_points(position);
            scatter(position(1:end-1,1),position(1:end-1,2),20,distance(1:length(position)-1,i)/30,'filled')
            
        end
        al=al+2;
        
        
        
    end
    clear position
    
end


%% Speed

speed=(distance)*1/30;
figure
for i = 1:length(S_frames)
    plot(speed(:,i))
    hold all
end

figure
for i = 1:length(S_frames)
    plot(diff(speed(:,i)))
    hold all
end
