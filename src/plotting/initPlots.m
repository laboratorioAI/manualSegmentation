function [] = initPlots(handles)
%initPlots inicializa los charts
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

22 February 2021
Matlab 9.9.0.1538559 (R2020b) Update 3.
%}


% - aux vars
params = getParams();
global kUser kGesture kRep % contadores

% vars para movimiento de ejes
global levantado moverBarraInicio moverBarraFin
levantado = false;
moverBarraInicio = false;
moverBarraFin = false;

% -  aux vars
global xi xo kXLength
kXLength = params.maxTamEmg;
xi = params.xi;
xo = params.xo;

%% EMG
% -  random values
x = 1:kXLength;
y = 0.5*max(params.yLims)*ones(size(x));

% -  FILTERED
p1 = line(x,y,'Parent',handles.mainAxes,'LineWidth',2);


% -  crear barras
p2 = line([xi xi],params.limsEmgFiltered,...
    'Parent',handles.mainAxes,'Marker','o','LineWidth',...
    params.lineWidth,'Color', ...
    params.leftLineColor, 'ButtonDownFcn',@moverlinea2);
p2.Annotation.LegendInformation.IconDisplayStyle = 'off';

p3 = line([xo xo],params.limsEmgFiltered...
    ,'Parent',handles.mainAxes,'Marker','o','LineWidth',...
    params.lineWidth,'Color',...
    params.rightLineColor,'ButtonDownFcn',@moverlinea1);
p3.Annotation.LegendInformation.IconDisplayStyle = 'off';

% -  MAV
p4 = line(0,0, 'Parent', handles.mainAxes,'LineWidth',0.5,'Color',[1 0 1]);
p4.Annotation.LegendInformation.IconDisplayStyle = 'off';

% IMPORTANTE: el orden de los children se usa para distinguir entre líneas
set(handles.mainAxes, 'Children', [p3 p2 p1 p4]);
legend(handles.mainAxes, 'Emg', ...
    'Location', 'northwest')

%%  quats!
% quat graph se inicializa igual que el mismo gráfico que en EMG
p1Q = line(x,y,'Parent',handles.axesQuats,'LineWidth',2);
handles.axesQuats.YLim = params.limitsQuatFilteredValue;

% -  crear barras
global DeviceType
emgFreq = params.emgFreq.(DeviceType);
global conversionFactor
conversionFactor = params.quatFreq/emgFreq; % prealloc
p2Q = line(conversionFactor*xi*[1 1], params.limitsQuatFilteredValue,...
    'Parent',handles.axesQuats,'LineWidth',1,'Color', ...
    params.leftLineColor);
p2Q.Annotation.LegendInformation.IconDisplayStyle = 'off';


p3Q = line(conversionFactor*xo*[1 1],params.limitsQuatFilteredValue...
    ,'Parent',handles.axesQuats,'LineWidth',1,'Color',...
    params.rightLineColor);
p3Q.Annotation.LegendInformation.IconDisplayStyle = 'off';

handles.axesQuats.XTick = [];

set(handles.axesQuats, 'Children', [p3Q p2Q p1Q]); % sin mav quat
legend(handles.axesQuats, 'Quaternion', ...
    'Location', 'northwest')


%% updating user data
[xi, xo] = setUserData(handles, kUser, kGesture, kRep);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function moverlinea2(~,~)
%%
global moverBarraInicio levantado
moverBarraInicio = true;
levantado = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function moverlinea1(~,~)
%%
global moverBarraFin levantado
moverBarraFin = true;
levantado = true;