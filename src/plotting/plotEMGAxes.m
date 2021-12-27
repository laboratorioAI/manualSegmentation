function [idxStart, emgLength] = plotEMGAxes(handles, nameUser, numUser, totalUsers, nameGesture, numGesture, totalGestures, kRep)
% dibuja las señales emg y quats según los datos de un usuario y una
% repetición.
% para eso inicia cargando las señales del usuario

parameters = getParams();

%% data load
global kXLength
[emgRep, idxStart, emgLength, mav, quats] = ...
    loadRepetition(nameUser, nameGesture, kRep);

% - conversion
global conversionFactor
conversionFactor = length(quats)/length(emgRep);

% - auxs
muestrasAq = length(emgRep);

xlimit = muestrasAq;
kXLength = xlimit; % global var del tam de la emg.

%% textos
global DeviceType
handles.nombreText.String = [nameUser ' (' num2str(numUser) '|' num2str(totalUsers) ')'];
handles.gestoText.String = [nameGesture ' (' num2str(numGesture) '|' num2str(totalGestures) ')'];
handles.kRepText.String = kRep;
handles.deviceText.String = DeviceType;


%% Plot on miniaxes
for cidx = 1:8
    idxSTR = num2str(cidx);
    cmd = ['ax = handles.axes' idxSTR ';'];
    eval(cmd);

    plot(ax, emgRep(:,cidx), 'LineWidth', 1); % no update

    xlim(ax, [0 xlimit]);
    ylim(ax, parameters.yLims);
    ax.YTick = []; % YTick
    ax.XTick = []; % XTick

end



%% main axes EMG: update
% - mav
handles.mainAxes.Children(4).XData = [1 xlimit];
handles.mainAxes.Children(4).YData = 8/3*mav*ones(1, 2);
handles.mainAxes.Children(4).LineWidth = 0.5;

% - filterring
freqFiltro = 0.05;
[Fb, Fa] = butter(5, freqFiltro, 'low'); % creando filtro

emgRep = emgRep - mean(emgRep, 'all'); % conversion
emgRep = filtfilt(Fb, Fa, abs(emgRep));

sumEMG = sum(emgRep, 2);

handles.mainAxes.Children(3).XData = 1:xlimit;
handles.mainAxes.Children(3).YData = sumEMG;
handles.mainAxes.XLim = [0 xlimit];
% handles.mainAxes.YLim = [0 max(sumEMG)];
handles.mainAxes.YLim = parameters.limsEmgFiltered; % fixed value

%% quats
xLimQuats = length(quats);
handles.axesQuats.Children(3).XData = 1:xLimQuats;

% "filtering of quats"
meanQuats = mean(quats);
quatFiltered = sum(abs(quats - meanQuats), 2);
handles.axesQuats.Children(3).YData = quatFiltered;
handles.axesQuats.XLim = [0 xLimQuats];


% mini
plot(handles.axesQwyxz, quats)
legend(handles.axesQwyxz, 'w', 'x', 'y', 'z', 'Location', ...
    'southoutside', 'Orientation','horizontal')
% xlabel(handles.axesQwyxz, 'Quaternions')
handles.axesQwyxz.XTick = [];
handles.axesQwyxz.YLim = [-1 1];
handles.axesQwyxz.XLim = [1 length(quats)];
% for i = 1:4
%     handles.axesQuats.Children(i).YData = quats(:, i);
% end
end

