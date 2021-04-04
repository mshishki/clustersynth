function varargout = selectInputDialog(varargin)
% SELECTINPUTDIALOG M-file for selectInputDialog.fig
%      SELECTINPUTDIALOG, by itself, creates a new SELECTINPUTDIALOG or raises the existing
%      singleton*.
%
%      H = SELECTINPUTDIALOG returns the handle to a new SELECTINPUTDIALOG or the handle to
%      the existing singleton*.
%
%      SELECTINPUTDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTINPUTDIALOG.M with the given input arguments.
%
%      SELECTINPUTDIALOG('Property','Value',...) creates a new SELECTINPUTDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selectInputDialog_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selectInputDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selectInputDialog

% Last Modified by GUIDE v2.5 04-May-2008 21:20:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selectInputDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @selectInputDialog_OutputFcn, ...
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

% --- Executes just before selectInputDialog is made visible.
function selectInputDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selectInputDialog (see VARARGIN)

% Choose default command line output for selectInputDialog
handles.output = hObject;

%Default output
handles.InputHandle = [];

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
            case 'title'
                set(hObject, 'Name', varargin{index+1});
            case 'inputtype'
                handles.InputType = varargin{index+1};
                set( handles.TypeText, 'String', ['Input Data Class: ', buildString( handles.InputType, '/')]);
            case 'tasklist'
                handles.TaskList4Menu = varargin{index+1};
                OutputListCellString = buildOutputList( handles.TaskList4Menu);
                %Popup Menu List
                set( handles.OutputText, 'String', OutputListCellString);
                %Default Selection is the last menu item = last task
                DefaultOutputIndex = max( getOutIndexByType( handles.TaskList4Menu, handles.InputType));
                %Adjust Popup Position
                set( handles.OutputText, 'Value', DefaultOutputIndex);
                %Default Output value
                handles.InputHandle = getInputHandleFromOutputText( cell2mat( ...
                           OutputListCellString( DefaultOutputIndex)));
            case 'inputhandlearray'
                handles.LastInputHandle = varargin{index+1};
                %Default Selection is the Setting from so far
                myOutputIndex = findInputHandleFromCellString( OutputListCellString, ...
                    handles.LastInputHandle);
                %Adjust Popup Position
                set( handles.OutputText, 'Value', myOutputIndex);
                %Default Output value
                handles.InputHandle = getInputHandleFromOutputText( cell2mat( ...
                           OutputListCellString( myOutputIndex)));
        end
    end
end


% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selectInputDialog wait for user response (see UIRESUME)
uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = selectInputDialog_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);


% --- Executes on selection change in OutputText.
function OutputText_Callback(hObject, eventdata, handles)
% hObject    handle to OutputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns OutputText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OutputText
OutputTextCellArray = get(hObject,'String');
OutputTextCell = OutputTextCellArray( get( hObject, 'Value'));
handles.InputHandle = getInputHandleFromOutputText( cell2mat( OutputTextCell));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function OutputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.output = get(hObject,'String');
handles.output = handles.InputHandle;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in CancelButton.
function CancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.output = get(hObject,'String');
handles.output = [];

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get( hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume( hObject);
else
    % The GUI is no longer waiting, just close it
    delete( hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said Cancel by hitting escape
    handles.output = 'Cancel';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    






