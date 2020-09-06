ct_im=read(obj,S_frames(1,1));

for i =1:length(S_frames)
    ct_im=read(obj,S_frames(i,2)+ex);
    imshow(ct_im)
    ref_point(i,:)=ginput(1);
    
end

distance=[];
al=0;
clear position
clear Dist2cent;
Dist2cent=[];
for i=1:length(S_frames)
    
    if i==1
        if fr_no(i,1)>fr_nu(i,1)
            position=[c_Position(1:fr_nu(i,1),1),c_Position(1:fr_nu(i,1),2)];
            distance(:,i)=dist_bt_points(position);
            [dist2cent, diffs_cent]= in_out(position, ref_point(i,:));
            Dist2cent(:,i)=dist2cent;
        elseif fr_no(i,1)<=fr_nu(i,1)
            
            position=[c_Position(1:fr_no(i,1),1),c_Position(1:fr_no(i,1),2)];
            distance(:,i)=dist_bt_points(position);
            [dist2cent, diffs_cent]= in_out(position, ref_point(i,:));
            Dist2cent(:,i)=dist2cent;
        end
        
        al=al+2;
    else
        
        if fr_no(i,1)>fr_nu(i,1)
            position=[c_Position(1:fr_nu(i,1),al+1),c_Position(1:fr_nu(i,1),al+2)];
            distance(1:length(position)-1,i)=dist_bt_points(position);
            [dist2cent, diffs_cent]= in_out(position, ref_point(i,:));
            Dist2cent((1:length(position)),i)=dist2cent;
        elseif fr_no(i,1)<=fr_nu(i,1)
            
            position=[c_Position(1:fr_no(i,1),al+1),c_Position(1:fr_no(i,1),al+2)];
            distance(1:length(position)-1,i)=dist_bt_points(position);
            [dist2cent, diffs_cent]= in_out(position, ref_point(i,:));
            Dist2cent((1:length(position)),i)=dist2cent;
        end
        al=al+2;
        
        
        
    end
    clear position dist2cent
    
end

%%
figure
hold on
for i = 1:11
    
scatter(Dist2cent(1:end-1,i),speed(:,i))
end 