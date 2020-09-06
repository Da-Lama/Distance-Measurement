% tracks HCT positions

%% initializing
clear all; close all;
clc;


%% loading file names

[f_names]=filenames_Test; % loads all the file names

for i= 2 % enter the file number
    
    
    %% choosing the folder
    
    % Specify the folder where the files live.
    myFolder = uigetdir('C:\Users\localadmin\Desktop\30-08-2020\',f_names(i,1:16)) ;
    % Check to make sure that folder actually exists.  Warn user if it doesn't.
    if ~isdir(myFolder)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
        uiwait(warndlg(errorMessage));
        return;
    end
    
    % Get a list of all files in the folder with the desired file name pattern.
    
    % Gets and loads the video file
    filePattern = fullfile(myFolder, '*.avi'); % Change to whatever pattern you need.
    theFiles = dir(filePattern);
    
    baseFileName = theFiles.name;
    fullFileName = fullfile(myFolder, baseFileName);
    obj = VideoReader(fullFileName);
    
    
    % Gets and loads the matfile
    load(f_names(i,1:20))
    data=eval(f_names(i,1:16));
    
    % Get the frame nos of approach trajectories
    BG=data.BG;
    S_frames=data.S_frames;
    % creating a mask
    image=read(obj,S_frames(1,1));
     %[r_mask] = create_mask(image);
     [r_mask] = load('r_mask.mat');
     mask = r_mask.r_mask;
    
    %% initializing variables
    C_position=zeros(150,2);
    H_position=zeros(150,2);
    T_position=zeros(150,2);
    st_pt=1;
    k=1;
    e=1;
    poly_med=0;% 1: curve fitting, 2: median , none or only centroid: 0
    len_l=size(S_frames);
    C_Position=[];
    H_Position=[];
    T_Position=[];
    c_Position=[];
    
    
    % things to play around with
    
    threshold=20;% play with this for better tracking
    visualization=0;% 2_centroid, 0_none, tail and center= '1'
    
    
    for jj=1%1:length(S_frames); Frame_selector(1)1:len_l(1)
        try
            % this function calculates the head, centroid and tail positions
            
            [C_position]=HCT_tracker_v2(obj,S_frames(jj,1),S_frames(jj,3),BG(jj,1),BG(jj,2),visualization,st_pt,threshold,poly_med,mask);
            
            %[H_position,C_position,T_position]=HCT_tracker_v3(obj,S_frames(jj,1),S_frames(jj,3),BG(jj,1),BG(jj,2),visualization,st_pt,threshold,poly_med,mask);
            
            close all
            C_Position=[C_Position;C_position];
            
            if jj==1
                c_Position=C_position;
                
            else
                aa=size(c_Position);
                c_Position(1:length(C_position),aa(2)+1)=C_position(:,1);
                c_Position(1:length(C_position),aa(2)+2)=C_position(:,2);
                
            end
            clear H_position C_position T_position
            
        catch
            warning('Problem using function');
            ex_1(e)=jj
            e=e+1;
        end
        %.............
        k=k+1
        
    end
    
    % storing data
    data.C_Position=C_Position;
    data.c_Position=c_Position;
    data.mask=mask;
    eval([f_names(i,1:16),'=data;'])
    save(f_names(i,1:20),f_names(i,1:16))
    
    
end


%% visualization to check where the head and tail flips
ct_im=read(obj,S_frames(jj,1));



figure
imshow(ct_im)
hold on
plot(C_Position(:,1),C_Position(:,2),'go','MarkerFaceColor','g')
