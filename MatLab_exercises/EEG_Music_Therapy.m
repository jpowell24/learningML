clc, clearvars, close all % used to clear commandline, variables, and close figures

% Storing path here, for easier use later
data_path = "/Users/jacksonpowell/Documents/GitHub/learningML/data_files/EEG1_music_therapy/sub-01/ses-01/eeg/sub-01_ses-01_task-musicTherapy_eeg.edf";

% Reads data from path
data = edfread(data_path);

% Extracts some information regarding data
info = edfinfo(data_path);
info.SignalLabels

% Essentially just samplling rate information
fs = info.NumSamples/seconds(info.DataRecordDuration)

samples = info.NumSamples(1) % Captures samples per .edf cell
time_per_sample = seconds(info.DataRecordDuration) % Captures duration per .edf cell, not that we must specify "seconds" for data type
sampling_frequency = samples / time_per_sample % Gives sampling frequency

plot_duration = 1000; % Duration in seconds
start_time = 0; % Start time of plot

plot_time = start_time:1/samples:plot_duration - (1/samples); % Creates x-axis for plot

dataFp1 = table(data.Fp1); % Extracts electrode Fp1 from dataset, note specifying data type "table"

dataFp1_cellarray = table2array(dataFp1); % Converts data into a cell array instead of table
dataFp1_array = vertcat(dataFp1_cellarray{:}); % Converts data again into single column list 

plot_dataFp1 = dataFp1_array(1:plot_duration * samples); % The duration of data we want to plot

plot(plot_time, plot_dataFp1); % Plotting time and data from Fp1 electrode

%%%%%%%%%%%%%
% A way to generate dummy data:
% plot(data.("Record Time"), randn(size(data.("Record Time")))+10)

% An alternative way to extract single electrode: 
% dataFp1 = edfread(data_path, 'SelectedSignals', 'Fp1');
%%%%%%%%%%%%%



