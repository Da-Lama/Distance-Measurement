% tracks HCT positions

%% initializing
clear all; close all;
clc;

%% loading file names

[f_names]=filenames_Test; % loads all the file names
load('s')% for random number generator
k=1;

for i= 1
    
    
    %% choosing the folder
    
    % Specify the folder where the files live.
    myFolder = uigetdir('C:\Users\localadmin\Desktop\PI_Analysis\Test Data',[f_names(i,1:17)]) ;
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
    filePattern_m = fullfile(myFolder, '.mat'); % Change to whatever pattern you need.
    theFiles_m = dir(filePattern_m);
    
    baseFileName_m = theFiles_m.name;
    fullFileName_m = fullfile(myFolder, baseFileName_m);
    temp_m=load(fullFileName_m);
    count=temp_m.count;
    
    % Get the frame nos of approach trajectories
    fr_no=100;
    [BG,S_frames]=Frame_extractor(count,fr_no);
    
    % randomizing the frames to analyze
    rng(s);
    Frs=size(S_frames);
    if Frs(1)>10
        Frame_selector=randperm(Frs(1),10);%Frs(1)
    else
        Frame_selector=1:Frs(1);
    end
    
    %% initializing variables
    H_position=zeros(150,2);
    C_position=zeros(150,2);
    T_position=zeros(150,2);
    visualization=1;
    st_pt=1;
    k=1;
    e=1;s
    poly_med=1;
    threshold=4.5;
    for jj=Frame_selector(9)%1:length(S_frames); Frame_selector(1)
        try
            % this function calculates the head, centroid and tail positions
            
            [H_position, C_position, T_position,posicionH, posicionT,pcdata,orientation]=HCT_tracker_v2(obj,S_frames(jj,1),S_frames(jj,2),BG(jj,1),BG(jj,2),visualization,st_pt,threshold,poly_med);
            close all
            
            
        catch
            warning('Problem using function');
            ex_1(e)=jj
            e=e+1;
        end
        
        
        
        %.............
        k=k+1
    end
    
end


%% visualization to check where the head and tail flips
ct_im=read(obj,S_frames(jj,1));
figure
for i=2:101
    
    imagesc(ct_im)
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    hold on
    plot(H_position(i,1),H_position(i,2),'ro','MarkerFaceColor','r')
    plot(C_position(i,1),C_position(i,2),'go')
    plot(T_position(i,1),T_position(i,2),'bo','MarkerFaceColor','b')
    xlim([0 700])
    ylim([0 700])
    title([num2str(i),'  -:-  ',num2str(orientation(i))])
    hold off
    pause
end
hold on
plot(C_position(:,1),C_position(:,2),'go')


%% some calculations to see where the head and tail flips

ind_temp=0;
xH=diff(H_position);
xT=diff(T_position);
xH_f=xH<-10 & xH>-80;
xT_f=(xT>10 & xT<80);
ind_H=find(xH_f(:,1:2)==1)+1
ind_T=find(xT_f(:,1:2)==1)+1
HT_diff=(H_position-T_position);
HT_n=diff(HT_diff);
HT_indx=HT_n<-10 & HT_n>-80;
ind_HT=find(HT_indx(:,1:2)==1)+1
