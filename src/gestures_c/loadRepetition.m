function [emgRep, idxStart, emgLength, mav, quats] = ...
    loadRepetition(nameUser, nameGesture, kRep)
% in this file the deviceType is set
global DeviceType % must be myo or gForce
%%
folderAddress = '.\data\';

filepath = [folderAddress nameUser '\userData.mat'];
loadedData = load(filepath);

DeviceType = loadedData.userData.deviceInfo.DeviceType;

%% Loading the data for the class rest
numRelaxSamples = length(loadedData.userData.gestures.relax.data);
mav = 0;
for i = 1:numRelaxSamples
    emgSample = double(loadedData.userData.gestures.relax.data{i}.emg);
    emgSample = emgSample - mean(emgSample, 'all'); % conversion
    mav = mav + mean( mean( abs(emgSample) ) );
end

%%
emgRep = double(loadedData.userData.gestures.(nameGesture).data{kRep}.emg);
emgLength = size(emgRep, 1);

idxStart = loadedData.userData.gestures.(nameGesture).data{kRep}.pointGestureBegins;


%% quats
quats = loadedData.userData.gestures.(nameGesture).data{kRep}.quaternions;
end
