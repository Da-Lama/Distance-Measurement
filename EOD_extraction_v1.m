clear all; close all;
clc;

global SR FR
SR=10000;     % Sampling frequency of audio
FR=30;
%% loading file names

[f_names]=filenames_Test; % loads all the file names
i=2

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
filePattern = fullfile(myFolder, '*.daq'); % Change to whatever pattern you need.
theFiles = dir(filePattern);

baseFileName = theFiles.name;
fullFileName = fullfile(myFolder, baseFileName);
[eod2_ttl1,time]=daqread(fullFileName);

eod=eod2_ttl1(:,2);
ttl=eod2_ttl1(:,1);
%%
load(f_names(i,1:20))
data=eval(f_names(i,1:16));

S_frames = data.S_frames;
lng=size(S_frames);
tet1=(SR*ana(1,1)/FR);
tet2=(SR*ana(1,2)/FR);
for t = 1
    
    ana= S_frames(t,1:3);
    [pks_eod,locs_eod,pks_ttl,locs_ttl]=eod_ttl_data(eod(tet1:tet2),time(tet1:tet2),ttl(tet1:tet2));
    
    [EOD,Spike,EODR]=soundAnalysis2(eod(tet1:tet2));
    
    
end


%%
subplot(2,1,1)
plot(a(:,2))
subplot(2,1,2)
plot(a(:,1))
plot(EODR)
xn = [];
xm= xn-50;

x=1:length(ttl((SR*ana(1,1)/FR:SR*ana(1,2)/FR)));
figure
plot(ttl((SR*ana(1,1)/FR:SR*ana(1,2)/FR)))
hold on
plot(x(locs_ttl),pks_ttl,'ko','markerfacecolor',[1 0 0])

x1=1:length(eod((SR*ana(1,1)/FR:SR*ana(1,2)/FR)));
figure
plot(eod((SR*ana(1,1)/FR:SR*ana(1,2)/FR)))
hold on
plot(x1(locs_eod),-pks_eod,'ko','markerfacecolor',[1 0 0])

360/12
(21460/10000)*30+53947


