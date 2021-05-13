function [xi, xo] = setUserData(handles, kUser, kGesture, kRep)

%% datos
[nameUser, totalUsers] = k2name(kUser);
[nameGesture, totalGestures] = k2gesture(kGesture);

%% Displaying the channels that have the highest activation
if strcmpi(nameGesture, 'sync')
    sensorsInRed = [3,4,8];
    sensorsInOgange = [1,2,5];
elseif strcmpi(nameGesture, 'waveIn')
    sensorsInRed = [1,7,8];
    sensorsInOgange = [2,6];
elseif strcmpi(nameGesture, 'waveOut')
    sensorsInRed = [3,4,8];
    sensorsInOgange = [1,2,5];
elseif strcmpi(nameGesture, 'open')
    sensorsInRed = [3,4,7,8];
    sensorsInOgange = [1,2];
    
elseif strcmpi(nameGesture, 'fist')
    sensorsInRed = [1,2,8];
    sensorsInOgange = [4,7];
    
elseif strcmpi(nameGesture, 'pinch')
    sensorsInRed = [3,6,7];
    sensorsInOgange = 8;
else
    sensorsInRed = [];
    sensorsInOgange = [];
end

for ch_i = 1:8
    if ~isempty(find( ch_i == sensorsInRed, 1))
        cmd = ['set(handles.sEMG' num2str(ch_i) ',''BackgroundColor'', [1, 0, 0]);'];
    elseif ~isempty(find( ch_i == sensorsInOgange, 1))
        cmd = ['set(handles.sEMG' num2str(ch_i) ',''BackgroundColor'', [0.93, 0.69, 0.13]);'];
    else
        cmd = ['set(handles.sEMG' num2str(ch_i) ',''BackgroundColor'', [0.94 0.94 0.94]);'];
    end
    eval(cmd);
end

%% 8 canales
[idxStart, emgLength] = plotEMGAxes(handles, nameUser, kUser,...
    totalUsers, nameGesture, kGesture, totalGestures, kRep);


%% guías!
global DeviceType
options = getParams();
emgFreq = options.emgFreq.(DeviceType);
try
    dat = load('indicesTodos.mat');
    indices = dat.indices;
    xi = indices.(nameUser).(nameGesture)(kRep,1);
    xo = indices.(nameUser).(nameGesture)(kRep,2);
catch
    xi = idxStart;
    xo = min(xi + round(options.gestureDuration*emgFreq), ...
        emgLength);
end

% saturating xi xo
if xi <= options.border
    xi = options.border + 1;
end

if xo - xi <= options.minSliderSeparation
    xo = xi + options.minSliderSeparation;
end

if xo >= emgLength - options.border
    xo = emgLength - options.border - 1;
end

if xo - xi <= options.minSliderSeparation
    xi = xo - options.minSliderSeparation;
end

assert(xo > xi)
%- txts
handles.inicioText.String = num2str(xi);
handles.finText.String = num2str(xo);

handles.textSegmentLength.String = ...
    [num2str(xo - xi) ' (' num2str((xo - xi)/emgFreq) ' s)'];

handles.mainAxes.Children(1).XData = [xo xo];
handles.mainAxes.Children(2).XData = [xi xi];

global conversionFactor
handles.axesQuats.Children(1).XData = conversionFactor*xo*[1 1];
handles.axesQuats.Children(2).XData = conversionFactor*xi*[1 1];

crearBarrasMini(handles, xi, xo);
end
