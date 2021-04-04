function varargout = newTaskDialog(varargin)
% NEWTASKDIALOG M-file for newTaskDialog.fig
%      NEWTASKDIALOG by itself, creates a new NEWTASKDIALOG or raises the
%      existing singleton*.
%
%      H = NEWTASKDIALOG returns the handle to a new NEWTASKDIALOG or the handle to
%      the existing singleton*.
%
%      NEWTASKDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWTASKDIALOG.M with the given input arguments.
%
%      NEWTASKDIALOG('Property','Value',...) creates a new NEWTASKDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newTaskDialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newTaskDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newTaskDialog

% Last Modified by GUIDE v2.5 30-Jan-2009 19:16:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newTaskDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @newTaskDialog_OutputFcn, ...
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

% --- Executes just before newTaskDialog is made visible.
function newTaskDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newTaskDialog (see VARARGIN)

% Choose default command line output for newTaskDialog
handles.output = [];

% Initialize data structs
handles.TaskList = [];
handles.NewTaskPosition = 0;
handles.NewTask = [];

% Update handles structure
guidata(hObject, handles);

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
%             case 'inputtype'
%                 handles.InputType = varargin{index+1};
%                 set( handles.TypeText, 'String', ['Input Data Class: ', buildString( handles.InputType, '/')]);
            case 'taskhandle'
                handles.TaskHandle = varargin{index+1};
            case 'tasklist'
                handles.TaskList = varargin{index+1};
% 				% default: append Task
% 				% might be changed
% 				handles.NewTaskPosition = min( handles.NewTaskPosition, size( handles.TaskList, 2) + 1);
% %                 OutputListCellString = buildOutputList( handles.TaskList);
% %                 %Popup Menu List
% %                 set( handles.OutputText, 'String', OutputListCellString);
% %                 %Default Selection is the last menu item = last task
% %                 DefaultOutputIndex = max( getOutIndexByType( handles.TaskList, handles.InputType));
% %                 %Adjust Popup Position
% %                 set( handles.OutputText, 'Value', DefaultOutputIndex);
% %                 %Default Output value
% %                 handles.InputHandle = getInputHandleFromOutputText( cell2mat( ...
% %                            OutputListCellString( DefaultOutputIndex)));
            case 'algonamecellarray'
                handles.AlgoNameCellArray = varargin{index+1};
%                 %Popup Menu List
%                 set( handles.NewTaskPUM, 'String', handles.AlgoNameCellArray);
%                 %Default Selection is the first menu item
%                 DefaultOutputIndex = 1;
%                 %Adjust Popup Position
%                 set( handles.NewTaskPUM, 'Value', DefaultOutputIndex);
% 				% Update handles structure
% 				guidata(hObject, handles);
% 				% Initialize NewTask data
% 				NewTaskPUM_Callback( handles.NewTaskPUM, eventdata, handles);
% 				% Retrieve handle data
% 				handles = guidata(hObject);

%             case 'inputhandlearray'
%                 handles.LastInputHandle = varargin{index+1};
%                 %Default Selection is the Setting from so far
%                 myOutputIndex = findInputHandleFromCellString( OutputListCellString, ...
%                     handles.LastInputHandle);
%                 %Adjust Popup Position
%                 set( handles.OutputText, 'Value', myOutputIndex);
%                 %Default Output value
%                 handles.InputHandle = getInputHandleFromOutputText( cell2mat( ...
%                            OutputListCellString( myOutputIndex)));
        end
    end
end

handles.NewTaskPosition = min( handles.TaskHandle, size( handles.TaskList, 2) + 1);

%Popup Menu List
set( handles.NewTaskPUM, 'String', handles.AlgoNameCellArray);
%Default Selection is the first menu item
DefaultOutputIndex = 1;
%Adjust Popup Position
set( handles.NewTaskPUM, 'Value', DefaultOutputIndex);
% Update handles structure
guidata(hObject, handles);
% Initialize NewTask data
NewTaskPUM_Callback( handles.NewTaskPUM, eventdata, handles);
% Retrieve handle data
handles = guidata(hObject);

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
set(handles.figure1,'WindowStyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selectInputDialog wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newTaskDialog_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    CancelButton_Callback( hObject, eventdata, handles);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    OKButton_Callback( hObject, eventdata, handles);
end    


% --- Executes on button press in ConnectButton.
function ConnectButton_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty( handles.InputNum)
	%nur 1 Element der Typelist
	myTypeList = {handles.InputTypeCellArray{ handles.InputNum}};

	myTask = handles.NewTask;
	myTaskList = handles.TaskList;
	myNewPosition = handles.NewTaskPosition;

	if ~isempty( myTypeList)
		%Bis hier berechnete Taskliste:
		myValidTaskList = buildTaskList( myTaskList, myNewPosition);
		myInputHandleArray = getInputHandleArrayFromTaskList( myTypeList, myValidTaskList, myTask.Context.InputHandleArray);
		if ~isempty( myInputHandleArray)
			myTask.Context = context_new( myInputHandleArray);

			%Task zurückliefern
			handles.NewTask = myTask;
		end
	end
end
        
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ConnectAllButton.
function ConnectAllButton_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectAllButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myTypeList = handles.InputTypeCellArray;
myTask = handles.NewTask;
myTaskList = handles.TaskList;
myNewPosition = handles.NewTaskPosition;

if ~isempty( myTypeList)
    %Bis hier berechnete Taskliste:
    myValidTaskList = buildTaskList( myTaskList, myNewPosition);
    myInputHandleArray = getInputHandleArrayFromTaskList( myTypeList, myValidTaskList, myTask.Context.InputHandleArray);
    if ~isempty( myInputHandleArray)
        myTask.Context = context_new( myInputHandleArray);

        %Task zurückliefern
        handles.NewTask = myTask;
    end
end
        
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myResult.OldTaskList = handles.TaskList;
myResult.NewTaskPosition = handles.NewTaskPosition;
myResult.NewTask = handles.NewTask;

handles.output = myResult;

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

handles.output = [];

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on selection change in NewTaskPUM.
function NewTaskPUM_Callback(hObject, eventdata, handles)
% hObject    handle to NewTaskPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns OutputText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OutputText
AlgoNamesCellArray = get(hObject,'String');
AlgoNameCell = AlgoNamesCellArray( get( hObject, 'Value'));
handles.NewTask = newTask( cell2mat( AlgoNameCell), []);

%Input Type List
handles.InputTypeCellArray = handles.NewTask.Algo.FuncPtr.getInputTypeList();
%Input Num List
handles.InputNumList = [];
if ~isempty( handles.InputTypeCellArray)
	myNumInputs = size( handles.InputTypeCellArray, 2);
	for i=1:myNumInputs
		handles.InputNumList = append( handles.InputNumList, {num2str( i)});
	end
else
	myNumInputs = 0;
	handles.InputNumList = {''};
end

%Popup Menu List
set( handles.InputPUM, 'String', handles.InputNumList);
%Default Selection is the first menu item
DefaultOutputIndex = 1;
%Adjust Popup Position
set( handles.InputPUM, 'Value', DefaultOutputIndex);
% Update handles structure
guidata(hObject, handles);
% Initialize NewTask data
InputPUM_Callback( handles.InputPUM, eventdata, handles);
% Retrieve handle data
handles = guidata(hObject);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function NewTaskPUM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NewTaskPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in InputPUM.
function InputPUM_Callback(hObject, eventdata, handles)
% hObject    handle to InputPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns InputPUM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InputPUM

InputNumCellArray = get(hObject,'String');
InputNumCell = InputNumCellArray( get( hObject, 'Value'));
handles.InputNum = str2num( cell2mat( InputNumCell));

if ~isempty( handles.InputTypeCellArray)
	myInputTypeCell = handles.InputTypeCellArray{ handles.InputNum};
	myTypeNum = size( myInputTypeCell, 2);
	myString = myInputTypeCell{ 1};
	for i=2:myTypeNum
		myString = append( myString, [ ', ', myInputTypeCell{ i}]);
	end
else
	myString = '';
end

set( handles.InputTypeText, 'String', myString);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function InputPUM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


