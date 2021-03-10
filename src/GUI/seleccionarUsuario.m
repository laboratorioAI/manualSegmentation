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

% Last Modified by GUIDE v2.5 20-Aug-2019 09:34:33

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
        str{3} = 'El siguiente usuario no tiene todos los gestos grabados:';
    else
        str{3} = 'Los siguientes usuarios no tienen todas las muestras grabadas:';
    end
    str{4} = '';
    numUsersWithErrors = length(usersWithIncompleteness);
    count = 4;
    for i = 1:numUsersWithErrors
        count = count + 1;
        str{count} = upper(usersWithIncompleteness{i}.name);
    end
    str{count + 1} = '';
    str{count + 2} = 'Por favor, envíe un email siguiendo las siguientes instrucciones:';
    str{count + 3} = '';
    str{count + 4} = 'Asunto: Software de Segmentación - Datos Incompletos';
    str{count + 5} = '';
    str{count + 6} = 'Direcciones de email:';
    str{count + 7} = 'marco.benalcazar@epn.edu.ec';
    str{count + 8} = 'lorena.barona@epn.edu.ec';
    str{count + 9} = 'angel.valdivieso@epn.edu.ec';
    str{count + 10} = '';
    str{count + 11} = ['En el contenido del email agregar una captura de pantalla ',...
        'de este mensaje junto con los siguientes datos de quien reporta el error:'];
    str{count + 12} = '';
    str{count + 13} = 'Nombre y Apellido';
    str{count + 14} = 'Celular';
    str{count + 15} = 'Institución';
    uiwait(errordlg(str, 'ERROR EN LOS DATOS'));
    delete(gcf);
    return;
end

% Verifica si todas las carpetas tienen la fotografía requerida
[flagCompleteness, usersWithIncompleteness] = checkCompletenessOfPictures();
if flagCompleteness ~= 1
    str{1} = 'ERROR';
    str{2} = '';
    if length(usersWithIncompleteness) == 1
        str{3} = 'El siguiente usuario no tiene la fotografía del brazalete colocado en el antebrazo:';
    else
        str{3} = 'Los siguientes usuarios no tienen la fotografía del brazalete colocado en el antebrazo:';
    end
    str{4} = '';
    numUsersWithErrors = length(usersWithIncompleteness);
    count = 4;
    for i = 1:numUsersWithErrors
        count = count + 1;
        str{count} = upper(usersWithIncompleteness{i}.name);
    end
    str{count + 1} = '';
    str{count + 2} = 'Por favor, envíe un email siguiendo las siguientes instrucciones:';
    str{count + 3} = '';
    str{count + 4} = 'Asunto: Software de Segmentación - Datos sin Fotografía';
    str{count + 5} = '';
    str{count + 6} = 'Direcciones de email:';
    str{count + 7} = 'marco.benalcazar@epn.edu.ec';
    str{count + 8} = 'lorena.barona@epn.edu.ec';
    str{count + 9} = 'angel.valdivieso@epn.edu.ec';
    str{count + 10} = '';
    str{count + 11} = ['En el contenido del email agregar una captura de pantalla ',...
        'de este mensaje junto con los siguientes datos de quien reporta el error:'];
    str{count + 12} = '';
    str{count + 13} = 'Nombre y Apellido';
    str{count + 14} = 'Celular';
    str{count + 15} = 'Institución';
    uiwait(errordlg(str, 'ERROR EN LOS DATOS'));
    delete(gcf);
    return;
end

[encabezado, usuarios, num] = crearListaDeUsuarios();
str = cell(num + 2, 1);
str{1} = encabezado;
for i = 2:(num + 1)
    str{i} = usuarios(i - 1).name;
end
str{num + 2} = 'MI NOMBRE NO ESTÁ EN ESTA LISTA';
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
    str = {'Debe seleccionar su nombre de la lista'};
    uiwait(msgbox(str, 'ADVERTENCIA', 'warning'));
else
    popMenuList = get(handles.listaDeUsuariosPopMenu, 'String');
    if strcmpi( popMenuList{valor}, 'MI NOMBRE NO ESTÁ EN ESTA LISTA')
        str{1} = 'INSTRUCCIONES';
        str{2} = '';
        str{3} = 'Para poder usar este programa debe estar autorizado.';
        str{4} = 'Por favor, envíe un email siguiendo las siguientes instrucciones:';
        str{5} = '';
        str{6} = 'Asunto: Software de Segmentación - Nuevo Usuario';
        str{7} = '';
        str{8} = 'Direcciones de email:';
        str{9} = 'marco.benalcazar@epn.edu.ec';
        str{10} = 'lorena.barona@epn.edu.ec';
        str{11} = 'angel.valdivieso@epn.edu.ec';
        str{12} = '';
        str{13} = 'En el contenido del email agregar los siguientes datos:';
        str{14} = '';
        str{15} = 'Nombre y Apellido';
        str{16} = 'Celular';
        str{17} = 'Institución';
        uiwait(msgbox(str, 'CONTACTO','help'));
        delete(gcf);
    else
        nameOfSegmentator = usuarios(valor - 1);
        qstring{1} = 'Usted ha selecionado:';
        qstring{2} = '';
        qstring{3} = upper(usuarios(valor - 1).name);
        qstring{4} = '';
        qstring{5} = '¿Es correcto?';
        choice = questdlg(qstring,'SEGMENTADOR DE DATOS',...
            'SI','NO','NO');
        if strcmpi(choice,'SI')
            delete(gcf);
            qstr = [upper(usuarios(valor - 1).name), ...
                ' ¿Es la primera vez que usa este programa?'];
            choice = questdlg(qstr,'SEGMENTADOR DE DATOS',...
                'SI','NO','NO');
            if strcmpi(choice,'SI')
                qqstr{1} = 'Vamos a resetear todos los contadores del programa';
                qqstr{2} = '';
                qqstr{3} = 'Si resetea los contadores PERDERÁ TODAS LAS SEGMENTACIONES REALIZADAS';
                qqstr{4} = '';
                qqstr{5} = '¿Desea continuar?';
                answer = questdlg(qqstr, ...
                    'PREGUNTA', ...
                    'SI','NO','NO');
                if strcmpi(answer,'SI')
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
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);