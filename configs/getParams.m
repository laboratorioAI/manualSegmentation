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

%% gestures 
parameters.numGestures = 12; % including sync

numReps = 2;% min number of reps
% numOfRepetitionsRelax = 3;
numOfRepetitionsSync = 1;

parameters.gestures = {'waveIn', 'waveOut', 'fist', 'open', 'pinch',...
    'up', 'down', 'forward', 'backward', 'left', 'right', 'sync'};
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

%% acquisition
parameters.emgFreq = 500;
parameters.quatFreq = 50;
parameters.recordingTime = 5; % segs
parameters.gestureDuration = 750;

%% lim values
parameters.maxTamEmg = 500*5*1.2; % not important, only used in the first 
% graph, can have any value

parameters.xi = 1000; % default x initial position for segmentation
parameters.xo = 2000; % default x last position for segmentation

parameters.yLims = [0 256]; % of raw emgs

% changing only by freq... keeping the previous values, /200*500 es la
% conversión entre frequencias
parameters.lowerBoundSamples = round(75  /200*500);
parameters.upperBoundSamples = round(600  /200*500);

parameters.lowerBoundSamplesSync = round(4*500);
parameters.upperBoundSamplesSync = round(8.5*500); % 5-8 segs


parameters.limsEmgFiltered = [0 200];

parameters.limitsQuatFilteredValue = [0 2.5];

%% colors
parameters.leftLineColor = [71, 47, 146]/255;
parameters.rightLineColor = [0 0.7410 0.4470];

