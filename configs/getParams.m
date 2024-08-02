function parameters = getParams()
%getParams is a function that returns the paramaters of the manual
%segmentation.
%
% Outputs
%   configs     -struct with fields
%
% Ejemplo
%    = getConfig()
%

%{
Laboratorio de Inteligencia y Visión Artificial
ESCUELA POLITÉCNICA NACIONAL
Quito - Ecuador

autor: ztjona!
jonathan.a.zea@ieee.org
Cuando escribí este código, solo dios y yo sabíamos como funcionaba.
Ahora solo lo sabe dios.

"I find that I don't understand things unless I try to program them."
-Donald E. Knuth

17 February 2021
Matlab 9.9.0.1538559 (R2020b) Update 3.
%}

%% recording times
parameters.recordingTime = 5; % segs
parameters.recordingTimeSync = 10; % segs

%% reps
numReps = 50;
numOfRepetitionsSync = 1;

%% gestures 11
% parameters.numGestures = 12; % including sync and excluding relax
% 
% parameters.gestures = {'waveIn', 'waveOut', 'fist', 'open', 'pinch',...
%     'up', 'down', 'forward', 'backward', 'left', 'right', 'sync'};

%% gestures 5
parameters.numGestures = 5; % including sync and excluding relax

parameters.gestures = {'waveIn', 'waveOut', 'fist', 'open', 'pinch'};

% 'relax', % nosegmentation of relax reps
% parameters.numSamplesPerGesture.relax = numOfRepetitionsRelax;

parameters.numSamplesPerGesture.waveIn = numReps;
parameters.numSamplesPerGesture.waveOut = numReps;
parameters.numSamplesPerGesture.fist = numReps;
parameters.numSamplesPerGesture.open = numReps;
parameters.numSamplesPerGesture.pinch = numReps;
parameters.numSamplesPerGesture.up = numReps;
parameters.numSamplesPerGesture.down = numReps;
parameters.numSamplesPerGesture.forward = numReps;
parameters.numSamplesPerGesture.backward = numReps;
parameters.numSamplesPerGesture.left = numReps;
parameters.numSamplesPerGesture.right = numReps;

parameters.numSamplesPerGesture.sync = numOfRepetitionsSync;

%% devices
global DeviceType % tells which device is used.
if isempty(DeviceType)
    DeviceType = 'gForce'; % default device
end
parameters.emgFreq.myo = 200;
parameters.emgFreq.gForce = 500;
parameters.quatFreq = 50;

%% Segmentation
parameters.gestureDuration = 1.5; % seconds for default segmentation size

%% chart
parameters.border = 5; % num of points on the left and right
parameters.lineWidth = 5; % sliders
parameters.minSliderSeparation = 20; % distance between sliders

% initials
parameters.xi = 200; % initial x initial position for segmentation
parameters.xo = 400; % initial x last position for segmentation

% lims values
parameters.limsEmgFiltered = [0 2.75];

parameters.limitsQuatFilteredValue = [0 2.5];

parameters.maxTamEmg = 500*5*1.2; % not important, only used in the first
% graph, can have any value

parameters.yLims = [-1 1]; % of raw emgs


%% Segmentation limits [seconds]
% changing only by freq...
parameters.lowerBound = 0.375; % [s]
parameters.upperBound = 3;

parameters.lowerBoundSync = 3; % [s]
parameters.upperBoundSync = 8.5;


%% colors
parameters.leftLineColor = [71, 47, 146]/255;
parameters.rightLineColor = [0 0.7410 0.4470];

