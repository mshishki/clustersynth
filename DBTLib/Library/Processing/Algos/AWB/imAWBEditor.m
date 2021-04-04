function varargout = imAWBEditor(varargin)
% IMAWBEDITOR M-file for imAWBEditor.fig
%      IMAWBEDITOR, by itself, creates a new IMAWBEDITOR or raises the existing
%      singleton*.
%
%      H = IMAWBEDITOR returns the handle to a new IMAWBEDITOR or the handle to
%      the existing singleton*.
%
%      IMAWBEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAWBEDITOR.M with the given input arguments.
%
%      IMAWBEDITOR('Property','Value',...) creates a new IMAWBEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imAWBEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imAWBEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imAWBEditor

% Last Modified by GUIDE v2.5 08-Feb-2009 01:39:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imAWBEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @imAWBEditor_OutputFcn, ...
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


% --- Executes just before imAWBEditor is made visible.
function imAWBEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imAWBEditor (see VARARGIN)

% Choose default command line output for imAWBEditor
handles.output = hObject;

handles.IsTool = 0;
handles.AWBEditorFigHandle = hObject;
handles.TaskHandle = varargin{ 1};
handles.AWBAnalysisSettingsInitial = varargin{ 2};
handles.AWBAnalysisSettings = handles.AWBAnalysisSettingsInitial;
handles.AWBAnalysisSettingsFinal = handles.AWBAnalysisSettings;

handles.RGB2LabMatrix = handles.AWBAnalysisSettings.Settings.RGBLin2LogLab.Matrix;

if( length( varargin) > 2)
	handles.UpdateImages = varargin{ 3};
else
	handles.UpdateImages = 1;	%default
end

if( length( varargin) > 3)
	handles.CloseOnOK = varargin{ 4};
else
	handles.CloseOnOK = 1;	%default
end

%DeltaR/G/B aus den Voreinstellungen berechnen:
myDeltaLab = [ 0; handles.AWBAnalysisSettings.Settings.Delta_a; handles.AWBAnalysisSettings.Settings.Delta_b];
myDeltaRGB = inv( handles.RGB2LabMatrix) * myDeltaLab;
handles.DeltaR = myDeltaRGB( 1);
handles.DeltaG = myDeltaRGB( 2);
handles.DeltaB = myDeltaRGB( 3);

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

%Anzeige
updateView( handles);

% UIWAIT makes imAWBEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function updateView( handles)
%Infos im imAWBEditorDialog zeichnen

%Slider und Infos setzen:
%myEditString = findobj( handles.AWBEditorFigHandle, 'Tag', 'DeltaRSlider');
set( handles.RInfo, 'String', num2str( handles.DeltaR, '%0.2f'));
set( handles.DeltaRSlider, 'Value', handles.DeltaR);
set( handles.GInfo, 'String', num2str( handles.DeltaG, '%0.2f'));
set( handles.DeltaGSlider, 'Value', handles.DeltaG);
set( handles.BInfo, 'String', num2str( handles.DeltaB, '%0.2f'));
set( handles.DeltaBSlider, 'Value', handles.DeltaB);

set( handles.UpdateCheckBox, 'Value', handles.UpdateImages);


function updateTaskView( handles)
%Infos im imAWBEditorDialog zeichnen

if( handles.UpdateImages)
	%Settings aktualisieren und nachfolgende Taskliste neu berechnen
	updateSettings( handles.AWBAnalysisSettings, handles.TaskHandle);
	updateTaskList( handles.TaskHandle);
end


function handles = updateParams( handles)
%Delta_a/b updaten

%Delta_ab aus den DeltaRGB berechnen:
myDeltaRGB = [ handles.DeltaR; handles.DeltaG; handles.DeltaB];
myDeltaLab = handles.RGB2LabMatrix * myDeltaRGB;
handles.AWBAnalysisSettings.Settings.Delta_a = myDeltaLab( 2);
handles.AWBAnalysisSettings.Settings.Delta_b = myDeltaLab( 3);


% --- Outputs from this function are returned to the command line.
function varargout = imAWBEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ZeroButton.
function ZeroButton_Callback(hObject, eventdata, handles)
% hObject    handle to ZeroButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Slider:
handles.DeltaR = 0;
handles.DeltaG = 0;
handles.DeltaB = 0;

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

%Anzeige
updateView( handles);
updateTaskView( handles);


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Slider:
myDeltaLab = [ 0; handles.AWBAnalysisSettingsInitial.Settings.Delta_a; handles.AWBAnalysisSettingsInitial.Settings.Delta_b];
myDeltaRGB = inv( handles.RGB2LabMatrix) * myDeltaLab;
handles.DeltaR = myDeltaRGB( 1);
handles.DeltaG = myDeltaRGB( 2);
handles.DeltaB = myDeltaRGB( 3);
% handles.DeltaR = 0;
% handles.DeltaG = 0;
% handles.DeltaB = 0;

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

%Anzeige
updateView( handles);
updateTaskView( handles);


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Settings setzen:
updateView( handles);
updateTaskView( handles);

if( ~handles.UpdateImages)	%Nur, falls deaktiviert, ansonsten schon in updateView aktualisiert
	%Settings aktualisieren und nachfolgende Taskliste neu berechnen
	updateSettings( handles.AWBAnalysisSettings, handles.TaskHandle);
	updateTaskList( handles.TaskHandle);
end

% Update handles und settingsFinal structure
handles.AWBAnalysisSettingsFinal = handles.AWBAnalysisSettings;
guidata(hObject, handles);

if handles.CloseOnOK
	close( handles.figure1);
end

	
% --- Executes on slider movement.
function DeltaRSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaRSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%get slider value
handles.DeltaR = get( hObject,'Value');

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

% adjust display 
updateView( handles);
updateTaskView( handles);


% --- Executes during object creation, after setting all properties.
function DeltaRSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DeltaRSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DeltaGSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaGSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%get slider value
handles.DeltaG = get( hObject,'Value');

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

% adjust display 
updateView( handles);
updateTaskView( handles);



% --- Executes during object creation, after setting all properties.
function DeltaGSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DeltaGSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function DeltaBSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaBSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%get slider value
handles.DeltaB = get( hObject,'Value');

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

% adjust display 
updateView( handles);
updateTaskView( handles);



% --- Executes during object creation, after setting all properties.
function DeltaBSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DeltaBSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in UpdateCheckBox.
function UpdateCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to UpdateCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UpdateCheckBox

%get CB value
handles.UpdateImages = get( hObject,'Value');

% Update handles structure
handles = updateParams( handles);
guidata(hObject, handles);

% adjust display 
updateView( handles);
updateTaskView( handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if exist( 'handles') && ~isempty( handles) && ~isequal( handles.AWBAnalysisSettingsFinal, getSettings( handles.TaskHandle))
	%Einstellungen haben sich geändert und müssen wieder updated werden
	updateSettings( handles.AWBAnalysisSettingsFinal, handles.TaskHandle);
	updateTaskList( handles.TaskHandle);
end

% Hint: delete(hObject) closes the figure
delete(hObject);


