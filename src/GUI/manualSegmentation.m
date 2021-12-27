function varargout = manualSegmentation(varargin)
%% MANUALSEGMENTATION MATLAB code for manualSegmentation.fig
% Last Modified by GUIDE v2.5 27-Dec-2021 11:54:39
% Jonathan A. Zea
% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @manualSegmentation_OpeningFcn, ...
    'gui_OutputFcn',  @manualSegmentation_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function manualSegmentation_OpeningFcn(hObject, ~, handles, varargin)
movegui('center');

% - logos
imgBuho = imread('buhoEPN.png');

imshow(imgBuho, 'Parent', handles.buhoAxes);

imgEscudo = imread('lab.png');
imshow(imgEscudo,  'Parent', handles.escudoAxes);

% - prealod data
global kUser kGesture kRep flags
flags.Stop = false;
file = load('.\matFiles\contadores.mat');
kGesture = file.kGesture;
kRep = file.kRep;
kUser = file.kUser;

% - initial grhaps
initPlots(handles);

% Choose default command line output for manualSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
drawnow



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = manualSegmentation_OutputFcn(~, ~, handles)
%%
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function goButton_Callback(~, ~, handles)
%%
params = getParams();
global DeviceType
emgFreq = params.emgFreq.(DeviceType);
global kUser kGesture kRep flags xi xo
nameGesture = k2gesture(kGesture);

if isequal(nameGesture, 'sync')
    lowerBoundSamples = params.lowerBoundSync*emgFreq;
    upperBoundSamples = params.upperBoundSync*emgFreq;
else
    lowerBoundSamples = params.lowerBound*emgFreq;
    upperBoundSamples = params.upperBound*emgFreq;
end

segmentTam = xo - xi;
if segmentTam <= lowerBoundSamples || segmentTam >= upperBoundSamples
    if segmentTam <= lowerBoundSamples
        str = ['Segment length is ',...
            num2str(segmentTam) ' (' num2str(segmentTam/emgFreq) ' s) ',...
            'must be greater than ' num2str(lowerBoundSamples),...
            ' (' num2str(lowerBoundSamples/emgFreq) ' s) '];
    else
        str = ['Segment length is ',...
            num2str(segmentTam) ' (' num2str(segmentTam/emgFreq) ' s) ',...
            'must be fewer than ' num2str(upperBoundSamples),...
            ' (' num2str(upperBoundSamples/emgFreq) ' s) '];
    end
    errordlg(str,'ERROR', 'modal');
else
    grabarIndices(kUser, kGesture, kRep, xi, xo);
    [kUser, kGesture, kRep] = incrementarIndices(kUser, kGesture, kRep);
    if ~flags.Stop
        [xi, xo] = setUserData(handles, kUser, kGesture, kRep);
    else
        % grabo de nuevo! con la flags actualizada
        grabarIndices(kUser, kGesture, kRep, xi, xo);
        printFinalMessage();
        delete(gcf);
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function volverButton_Callback(~, ~, handles)
%%
global kUser kGesture kRep xi xo

if kUser == 1 && kGesture == 1 && kRep == 1
    msgbox('Not possible');
    
else
    [kUser, kGesture, kRep] = bajarIndices(kUser, kGesture, kRep);
    
    [xi, xo] = setUserData(handles, kUser, kGesture, kRep);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function figure1_WindowButtonMotionFcn(~, ~, handles)
%% movimiento del mouse
global moverBarraInicio moverBarraFin levantado
global xi xo kXLength
global DeviceType

if isequal(get(gca, 'Tag'),'mainAxes')
    eje = gca;
    
    %
    C = eje.CurrentPoint;
    x = C(1,1);
    y = C(1,2);
    
    %
    if x > kXLength
        x = kXLength - 1;
    end
    
    if x < 0
        x = 1;
    end
    
    %
    params = getParams();
    emgFreq = params.emgFreq.(DeviceType);
    if levantado
        if moverBarraInicio
            if x < xo
                x = round(x);
                eje.Children(2).XData = [x x];
                handles.inicioText.String = num2str(x);
                xi = x;
                
                % mover barras other plot!
                moverBarrasMini(handles, 'xi', xi);
                
                % segment length
                handles.textSegmentLength.String = ...
                    [num2str(xo - xi) ' (' num2str((xo - xi)/emgFreq) ' s)'];
            end
        end
        if moverBarraFin
            if x > xi
                x = round(x);
                eje.Children(1).XData = [x x];
                handles.finText.String = num2str(x);
                xo = x;
                
                % mover barras other plot!
                moverBarrasMini(handles, 'xo', xo);
                
                % segment length
                handles.textSegmentLength.String = ...
                    [num2str(xo - xi) ' (' num2str((xo - xi)/emgFreq) ' s)'];
            end
        end
    end
    
    %
    %     if (x > 1 && x < kXLength) && (y > 0 && y < handles.mainAxes.YLim(2))
    %         % handles.xPosText.String = x;
    % %         handles.xPosText.String = sprintf('x: %.2f, y:%.2f', x, y);
    %     else
    %         handles.xPosText.String = '';
    %     end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function figure1_WindowButtonUpFcn(~, ~, ~)
%% banderas para el reconocimiento del mouse
global levantado moverBarraInicio moverBarraFin
levantado = false;
moverBarraInicio = false;
moverBarraFin = false;

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)

if(isequal(eventdata.Key,'return') || isequal(eventdata.Key,'space'))
    goButton_Callback(hObject, eventdata, handles);
end

if(isequal(eventdata.Key,'backspace'))
    volverButton_Callback(hObject, eventdata, handles);
end

% --- Executes on mouse press over axes background.
function mainAxes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mainAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function acercaDe_Callback(hObject, eventdata, handles)
% hObject    handle to acercaDe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = {'Manual segmentation of EMG signals for Hand Gesture Recognition'
    ''
    'Versión 3 reactualizada por Jonathan Zea'
    'Proyecto Reconocimiento de Gestos'
    ''
    'Revisión 1: 16 de agosto de 2019'
    'Revisión 2: 20 de agosto de 2019'
    'Revisión 3: 31 de agosto de 2019'
    'Revisión 4: 17 de febrero de 2021'
    'Revision 5: April 142021 (translation)'
    ''
    'Versión 1 creada por el Ing. Jonathan Zea'
    'Agosto de 2018'};
msgbox(str,'ABOUT...','help');

% --------------------------------------------------------------------
function contactInformation_Callback(hObject, eventdata, handles)
% hObject    handle to contactInformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = {'CONTACT INFORMATION'
    ''
    'In case you detect an error in this software'
    'please report it by email to:'
    ''
    'Subject: HGR - Manual Segmentation Software'
    ''
    'Email address:'
    'laboratorio.ia@epn.edu.ec'
    ''
    'With the screenshot of the error.'
    'Thank you.'};

msgbox(str, 'CONTACT','help');


% --------------------------------------------------------------------
function printFinalMessage()
str = {'Thank you, you finished the segmentation.'
    'The segmentation information is stored in "matFiles/indicesTodos.mat".'
    };
uiwait(msgbox(str,'MESSAGE','help'));

% --- Executes during object creation, after setting all properties.
function mainAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate mainAxes


% --------------------------------------------------------------------
function myoFigure_Callback(hObject, eventdata, handles)
% hObject    handle to myoFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagenMyo();

% --------------------------------------------------------------------
function gForceFigure_Callback(hObject, eventdata, handles)
% hObject    handle to gForceFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagenGForce();


% --------------------------------------------------------------------
function videosGestures_Callback(hObject, eventdata, handles)
% hObject    handle to videosGestures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function syncGesture_Callback(hObject, eventdata, handles)
% hObject    handle to syncGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('sync');

% --------------------------------------------------------------------
function relaxGesture_Callback(hObject, eventdata, handles)
% hObject    handle to relaxGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('relax');

% --------------------------------------------------------------------
function fistGesture_Callback(hObject, eventdata, handles)
% hObject    handle to fistGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('fist');

% --------------------------------------------------------------------
function openGesture_Callback(hObject, eventdata, handles)
% hObject    handle to openGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('open');

% --------------------------------------------------------------------
function waveInGesture_Callback(hObject, eventdata, handles)
% hObject    handle to waveInGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('waveIn');

% --------------------------------------------------------------------
function waveOutGesture_Callback(hObject, eventdata, handles)
% hObject    handle to waveOutGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('waveOut');

% --------------------------------------------------------------------
function upG_Callback(hObject, eventdata, handles)
% hObject    handle to upG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('up');

% --------------------------------------------------------------------
function downG_Callback(hObject, eventdata, handles)
% hObject    handle to downG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('down');

% --------------------------------------------------------------------
function leftG_Callback(hObject, eventdata, handles)
% hObject    handle to leftG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('left');

% --------------------------------------------------------------------
function rightG_Callback(hObject, eventdata, handles)
% hObject    handle to rightG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('right');

% --------------------------------------------------------------------
function forwardG_Callback(hObject, eventdata, handles)
% hObject    handle to forwardG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('forward');

% --------------------------------------------------------------------
function backG_Callback(hObject, eventdata, handles)
% hObject    handle to backG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('backward');


% --------------------------------------------------------------------
function pinchGesture_Callback(hObject, eventdata, handles)
% hObject    handle to pinchGesture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playGif('pinch');
