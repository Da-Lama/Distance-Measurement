clear all; close all
%% Declaring variables

global SR FR
SR=10000;     % Sampling frequency of audio
FR=30;        % Framerate of Video
all_EOD=[];
all_Spike=[];
all_EODR=[];
[f_names]=filenames_Test; % loads all the file names

for i = 1
    %% loading files
    [FileName,PathName]=uigetfile('*.avi','Select the Video');
    obj = VideoReader([PathName,   FileName]);
    % read daq soundfile: sound(:,1) = EODs, sound(:,2)=TTL of camers
    [sound, t]=daqread([PathName,  FileName(1:end-4),'.daq']);
    
    
    %% generate a general timebase of the audio data
    timebase=0:(1/SR):length(sound(1:end-1,1))/SR;
    
    %% Detect pulses in the video TTL train
    camera=sound(:,1);
    [value,sample]=findpeaks(-camera,'MINPEAKHEIGHT',0.08);
    EODs=sound(1:end,2);
    
    %% Loading matfiles
    
    load(f_names(i,1:20))
    data=eval(f_names(i,1:16));
    
    %% define frame to be analyzed (from, to)
    
    S_frames = data.S_frames;
    lng=size(S_frames);
    for t = 1:lng(1)
        
        ana= S_frames(t,1:2);
        
        % Sound Analysis
        [EOD,Spike,EODR]=soundAnalysis2(EODs(SR*ana(1,1)/FR:SR*ana(1,2)/FR));
        
        all_EOD=[all_EOD;EOD;10];
        all_Spike=[all_Spike;Spike;10];
        all_EODR = [all_EODR; EODR;100];
    end
end




%% Plotting
figure
subplot(3,1,1)
plot(all_EOD)
subplot(3,1,2)
plot(all_EODR)
subplot(3,1,3)
plot(all_Spike)


%% other stuff

% daqread('C:\Users\localadmin\Desktop\Data\Fish_03_20200618T180310.daq');
