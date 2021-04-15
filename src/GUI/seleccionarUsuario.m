function varargout = seleccionarUsuario(varargin)
% SELECCIONARUSUARIO MATLAB code for seleccionarUsuario.fig
%      SELECCIONARUSUARIO, by itself, creates a new SELECCIONARUSUARIO or raises the existing
%      singleton*.
%
%      H = SELECCIONARUSUARIO returns the handle to a new SELECCIONARUSUARIO or the handle to
%      the existing singleton*.
%
%      SELECCIONARUSUARIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECCIONARUSUARIO.M with the given input arguments.
%
%      SELECCIONARUSUARIO('Property','Value',...) creates a new SELECCIONARUSUARIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before seleccionarUsuario_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to seleccionarUsuario_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help seleccionarUsuario

% Last Modified by GUIDE v2.5 14-Apr-2021 13:01:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @seleccionarUsuario_OpeningFcn, ...
    'gui_OutputFcn',  @seleccionarUsuario_OutputFcn, ...
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


% --- Executes just before seleccionarUsuario is made visible.
function seleccionarUsuario_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to seleccionarUsuario (see VARARGIN)

% Choose default command line output for seleccionarUsuario
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes seleccionarUsuario wait for user response (see UIRESUME)
% uiwait(handles.figure1);
movegui(hObject,'center'); % mostrando en el centro
% Verifica si la carpeta de datos tiene todos los gestos y todas las
% muestras por gesto completos
global usuarios;
[flagCompleteness, usersWithIncompleteness] = checkCompletenessOfSamples();
if flagCompleteness ~= 1
    str{1} = 'ERROR';
    str{2} = '';
    if flagCompleteness == -1
        str{3} = 'Following user has incomplete data:';
    else
        str{3} = 'Following users have incomplete data:';
    end
    str{4} = '';
    numUsersWithErrors = length(usersWithIncompleteness);
    count = 4;
    for i = 1:numUsersWithErrors
        count = count + 1;
        str{count} = upper(usersWithIncompleteness{i}.name);
    end
    str{count + 1} = '';

    uiwait(errordlg(str, 'ERROR IN DATA'));
    delete(gcf);
    return;
end

% Verifica si todas las carpetas tienen la fotografía requerida
[flagCompleteness, usersWithIncompleteness] = checkCompletenessOfPictures();
if flagCompleteness ~= 1
    str{1} = 'ERROR';
    str{2} = '';
    if length(usersWithIncompleteness) == 1
        str{3} = 'The following user does not have photography:';
    else
        str{3} = 'The following users do not have photography:';
    end
    str{4} = '';
    numUsersWithErrors = length(usersWithIncompleteness);
    count = 4;
    for i = 1:numUsersWithErrors
        count = count + 1;
        str{count} = upper(usersWithIncompleteness{i}.name);
    end
    str{count + 1} = '';
    str{count + 2} = 'Please, contact lab members about this issue.';
    
    uiwait(errordlg(str, 'ERROR IN DATA'));
    delete(gcf);
    return;
end

[encabezado, usuarios, num] = crearListaDeUsuarios();
str = cell(num + 2, 1);
str{1} = encabezado;
for i = 2:(num + 1)
    str{i} = usuarios(i - 1).name;
end
% str{num + 2} = 'MI NOMBRE NO ESTÁ EN ESTA LISTA';
set(handles.listaDeUsuariosPopMenu, 'String', str);


% --- Outputs from this function are returned to the command line.
function varargout = seleccionarUsuario_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
try
    varargout{1} = handles.output;
catch
end

% --- Executes on selection change in listaDeUsuariosPopMenu.
function listaDeUsuariosPopMenu_Callback(hObject, eventdata, handles)
% hObject    handle to listaDeUsuariosPopMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listaDeUsuariosPopMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listaDeUsuariosPopMenu


% --- Executes during object creation, after setting all properties.
function listaDeUsuariosPopMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listaDeUsuariosPopMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject, 'BackgroundColor', 'white');
end

% --- Executes on button press in aceptarPushbutton.
function aceptarPushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to aceptarPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global usuarios;
valor = get(handles.listaDeUsuariosPopMenu, 'Value');
if valor == 1 % No se selecciona un nombre
    str = {'Select your name in the list'};
    uiwait(msgbox(str, 'WARNING', 'warning'));
else
%     popMenuList = get(handles.listaDeUsuariosPopMenu, 'String');
    
    nameOfSegmentator = usuarios(valor - 1);
    qstring{1} = 'You selected:';
    qstring{2} = '';
    qstring{3} = upper(usuarios(valor - 1).name);
    qstring{4} = '';
    qstring{5} = 'Is it correct?';
    choice = questdlg(qstring,'Info of the segmentator',...
        'YES','NO','YES');
    if strcmpi(choice,'YES')
        delete(gcf);
        qstr = [upper(usuarios(valor - 1).name), ...
            '. Is this the first time you use this program?'];
        choice = questdlg(qstr,'Info of the segmentator',...
        'YES','NO','YES');
        if strcmpi(choice,'YES')
            qqstr{1} = 'Reseting counters';
            qqstr{2} = '';
            qqstr{3} = 'If you do this, YOU WILL LOSE ALL THE SEGMENTATIONS';
            qqstr{4} = '';
            qqstr{5} = 'Do you want to continue?';
            answer = questdlg(qqstr, ...
                'Quesion', ...
                'YES','NO','NO');
            if strcmpi(answer,'YES')
                resetContadores();
            else
                delete(gcf);
                return;
            end
        end
        manualSegmentation();
        save('.\matFiles\nameOfSegmentator.mat', 'nameOfSegmentator');
    end
    
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
