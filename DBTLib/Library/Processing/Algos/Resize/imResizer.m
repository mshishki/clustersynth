function varargout = imResizer(varargin)
%IMRESIZER M-file for imResizer.fig
%      IMRESIZER, by itself, creates a new IMRESIZER or raises the existing
%      singleton*.
%
%      H = IMRESIZER returns the handle to a new IMRESIZER or the handle to
%      the existing singleton*.
%
%      IMRESIZER('Property','Value',...) creates a new IMRESIZER using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to imResizer_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IMRESIZER('CALLBACK') and IMRESIZER('CALLBACK',hObject,...) call the
%      local function named CALLBACK in IMRESIZER.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Created by Gregor Fischer - Cologne University of Applied Sciences
%
% Copyright Gregor Fischer/Institute of Media an Imaging Technology,
% Cologne University of Applied Sciences, in co-operation with Leica Camera
% AG, Solms

% Edit the above text to modify the response to help imResizer

% Last Modified by GUIDE v2.5 14-May-2008 01:03:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imResizer_OpeningFcn, ...
                   'gui_OutputFcn',  @imResizer_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


%--------------------------------------------------------------------------
% --- Executes just before imResizer is made visible.
function imResizer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for imResizer
handles.output = hObject;

if (~isempty( varargin) && size( varargin, 2)==1)
    %ImageObject ist erster und einziger Parameter
    handles.IsTool = 1;
    
    ImageObject = varargin{ 1};
else
    handles.IsTool = 0;
    handles.TaskHandle = varargin{ 1};
    handles.ResizeSettingsInitial = varargin{ 2};
    
    ImageObject = varargin{ 3};
end

if( ~isType( ImageObject, 'Image'))
    return;
end

%Cursor Check Buttons Icons installieren
IDrag = imread('DragROI.bmp');
IPlus = imread('Plus.bmp');

set( handles.DragROIButton, 'CData', IDrag);
set( handles.ZoomInButton, 'CData', IPlus);

%Bild installieren
if ~isempty( varargin)
    handles = installImage( handles, ImageObject);
end

if handles.IsTool
    
    %Initialisierung Scaling Factor 
    User_entry = str2double( get( handles.ScalingFactor, 'String'));
    handles.ScalingFactor = User_entry;

    %Initialisierung Interpol. Mode
    Val = get( handles.InterpolationPUM, 'Value');
    String_list = get( handles.InterpolationPUM, 'String');
    Selected_string = String_list{ Val}; % Convert from cell array to string
    handles.InterpolationMode = Selected_string;
else    
    %Bildausschnitt
    handles.ImRect = handles.ResizeSettingsInitial.Settings.CropRect;

	%Initialisierung Scaling Factor 
    imSizeX = handles.ImRect( 3);
    imSizeY = handles.ImRect( 4);
%     imSizeX = size( handles.ImageObject.Data.ImageData, 2);
%     imSizeY = size( handles.ImageObject.Data.ImageData, 1);
    imSizeXDest = handles.ResizeSettingsInitial.Settings.Size( 1);
    imSizeYDest = handles.ResizeSettingsInitial.Settings.Size( 2);
    NumPixSource = imSizeX * imSizeY;
    NumPixDest = imSizeXDest * imSizeYDest;
    handles.ScalingFactor = sqrt( NumPixSource / NumPixDest);

    %Initialisierung Interpol. Mode
    handles.InterpolationMode = handles.ResizeSettingsInitial.Settings.Method;
    
end

% Update handles structure
guidata(hObject, handles);

%Anzeige
updateView( handles);

% UIWAIT makes imResizer wait for user response (see UIRESUME)
% uiwait(handles.imResizerFigure);


%--------------------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = imResizer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%--------------------------------------------------------------------------
function theOutHandles = installImage( theInHandles, theImageObject)
% Installiert das Bildobjekt im Dialog

theOutHandles = theInHandles;

if isempty( theImageObject)
    return;
end

%Bildobjekt installieren
theOutHandles.ImageObject = theImageObject;

%Bildausschnitt auf Gesamtbild initialisieren
ImRect = [ 1, 1,  size( theImageObject.Data.ImageData, 2), size( theImageObject.Data.ImageData, 1)];               
theOutHandles.ImRect = ImRect;

%Dateinamen merken und in den Dialogtitel übernehmen
[ Path, Name, Ext, Version] = fileparts( theImageObject.Data.FileName);
set( theOutHandles.uipanel1,'Title',['File: ', Name, Ext]);
theOutHandles.FileName = theImageObject.Data.FileName;
 
% Gammakorrektur und Anzeige
myControl = getApplicationData( 'Control');
theOutHandles.DisplayImageData = theImageObject.FuncPtr.buildDisplayImage( theImageObject.Data.ImageData, myControl.Display);

%Koordinatenachsen für beide Bildanzeigen auf gesamten Bildausschnitt setzen
%Muß für updateView gültig sein
set( theOutHandles.axes1, 'xlim', [ImRect( 1), ImRect( 3)]);
set( theOutHandles.axes1, 'ylim', [ImRect( 2), ImRect( 4)]);
set( theOutHandles.axes2, 'xlim', [ImRect( 1), ImRect( 3)]);
set( theOutHandles.axes2, 'ylim', [ImRect( 2), ImRect( 4)]);


%--------------------------------------------------------------------------
function Image1_ButtonDownFcn(hObject, eventdata)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

%Dialogdaten holen
handles = guidata( hObject);

%ButtonDownFunktion des Axenobjekts aufrufen
axes1_ButtonDownFcn( hObject, eventdata, handles);


%--------------------------------------------------------------------------
function Image2_ButtonDownFcn(hObject, eventdata)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Dialogdaten holen
handles = guidata( hObject);

%ButtonDownFunktion des Axenobjekts aufrufen
axes2_ButtonDownFcn( hObject, eventdata, handles);


%--------------------------------------------------------------------------
% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.IsTool

    %Bildausschnitt
    CroppedImage = imcrop( handles.ImageObject.Data.ImageData, handles.ImRect);
    %Umskalierung
    ResizedImage = imresize( CroppedImage, 1/handles.ScalingFactor, handles.InterpolationMode);

    %Neues Bildobjekt eröffnen
    %Nur Bilddaten ersetzen, ansonsten alte Bildobjektdaten übernehmen
    myImageObject = handles.ImageObject;
    myImageObject.Data.ImageData = ResizedImage;
    %Neuer Dateiname automatisch generieren
    myImageObject.Data.FileName = '';
    %Bildfenster öffnen
    openImage( getApplicationData( 'Control'), myImageObject);

    %ImResizerDialog schließen
    close( handles.imResizerFigure);

else
    
    %Settings setzen:
    myResizeSettings.Settings.RelativeCropRect = [];

    %Bildausschnitt
    myResizeSettings.Settings.CropRect = handles.ImRect;

    %Umskalierung:
    imSizeX = size( handles.ImageObject.Data.ImageData, 2);
    imSizeY = size( handles.ImageObject.Data.ImageData, 1);
    myResizeSettings.Settings.Size = [ handles.ImRect( 3), handles.ImRect( 4)] / handles.ScalingFactor;
%    myResizeSettings.Settings.Size = [ imSizeX, imSizeY] / handles.ScalingFactor;
    myResizeSettings.Settings.Method = handles.InterpolationMode;

    %Settings aktualisieren und nachfolgende Taskliste neu berechnen
    updateSettings( myResizeSettings, handles.TaskHandle);
    updateTaskList( handles.TaskHandle);

end

%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function MouseModes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MouseModes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%set( hObject, 'SelectedObject', []);  % No selection
set( hObject,'SelectionChangeFcn', @SelectionChangeFcn);

handles.MouseMode = 'Drag';
        zoom off;
guidata( hObject, handles);



%--------------------------------------------------------------------------
function SelectionChangeFcn( hObject, eventdata)
% hObject    handle to MouseModes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

%Dialogdaten holen
handles = guidata( hObject);

switch eventdata.NewValue
    
    case handles.DragROIButton
        handles.MouseMode = 'Drag';
        zoom off;
        
    case handles.ZoomInButton
        handles.MouseMode = 'ZoomIn';
        zoom on;
end

%Dialogdaten übergeben
guidata( hObject, handles);
            


%--------------------------------------------------------------------------
% --- Executes on mouse motion over figure - except title and menu.
function imResizerFigure_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to imResizerFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield( handles, 'ImageObject')
    
    %Cursorposition in Bildbereich 1
    PositionImage1 = get( handles.axes1, 'CurrentPoint');
    CursorPositionIm1 = [ PositionImage1( 1,1), PositionImage1( 1,2)];

    %sichtbare Bildkoordinaten für beide Bildbereiche aus den Achsen herauslesen, wegen Zoom variabel
    XLim = get( handles.axes1, 'xlim');
    YLim = get( handles.axes1, 'ylim');
    ImRect1 = [ XLim( 1), YLim( 1), XLim( 2)-XLim( 1), YLim( 2)-YLim( 1)];
    ImRect2 = [ 1, 1, size( handles.DisplayImageData, 2), size( handles.DisplayImageData, 1)];

    Inside = 0;
    if pointInsideRect( CursorPositionIm1, ImRect1)
        %Cursor innerhalb Bildbereich 1:
        if strcmp( handles.MouseMode, 'Drag')
            % Drag Mode, Cursor Kreuz setzen
            set( hObject, 'Pointer', 'crosshair');
        else
            % Zoom Mode, Zoom anschalten
            zoom on;
        end
        %Cursorposition anzeigen
        set( handles.XYPositionText, 'String', [ '( ', ...
                    num2str( floor( CursorPositionIm1( 1))), ', ', ...
                    num2str( floor( CursorPositionIm1( 2))), ')']);
        %Merken, daß Cursor im Bildbereich
        Inside = 1;
    else
        %Cursorposition ausblenden
        set( handles.XYPositionText, 'String', '');
    end

    %Cursorposition in Bildbereich 2
    PositionImage2 = get( handles.axes2, 'CurrentPoint');
    CursorPositionIm2 = [ PositionImage2( 1,1), PositionImage2( 1,2)];
    if pointInsideRect( CursorPositionIm2, ImRect2)
        %Cursor innerhalb Bildbereich 1:
        %Zoom ausschalten
        zoom off;
        %Cursor auf Handsymbol setzen
        set( hObject, 'Pointer', 'hand');
        %Merken, daß Cursor im Bildbereich
        Inside = 1;
    end

    if ~Inside
        %Ausserhalb Cursor auf Pfeilsymbol setzen
        set( hObject, 'Pointer', 'arrow');
    end
end



%--------------------------------------------------------------------------
% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Nur Rechteckziehen in Bildbereich 1 abfangen
switch handles.MouseMode
    case 'Drag'
        %Rechteck (Bildausschnitt) neu festlegen
        axes1_Drag( hObject, eventdata, handles);
end
    


%--------------------------------------------------------------------------
function axes1_Drag(hObject, eventdata, handles)

%Anfangspunkt holen
Point1 = get( gca,'CurrentPoint');      % button down detected
%Rechteck ziehen
FinalRect = rbbox();                    % return figure units
%Endpunkt holen
Point2 = get(gca,'CurrentPoint');       % button up detected
%Zeilenvektoren bilden
P1 = Point1(1,1:2);                     % extract x and y
P2 = Point2(1,1:2);
%Linke obere Ecke
LeftUpperCorner = min( P1, P2);         % calculate locations
%Rechteckgröße in Pixeln
Dimension = abs( P1-P2);                % and dimensions
 
%Bildgöße:
ImageWidth = size( handles.DisplayImageData, 2);
ImageHeight = size( handles.DisplayImageData, 1);
%Rechteck auf den inneren Bildbereich begrenzen
ImRect( 1) = max( 1, min( ImageWidth, LeftUpperCorner( 1)));
ImRect( 2) = max( 1, min( ImageHeight, LeftUpperCorner( 2)));
ImRect( 3) = max( 0, min( Dimension( 1), ImageWidth-ImRect( 1)));
ImRect( 4) = max( 0, min( Dimension( 2), ImageHeight-ImRect( 2)));

if (ImRect( 3) ~= 0 && ImRect( 4) ~= 0)
    %Rechteck gültig (ansonsten alte Einstellungen lassen)

    %Rechteck übernehmen und übergeben
    handles.ImRect = ImRect;
    guidata( hObject, handles);

    %Anzeigen aktualisieren
    updateView( handles);

end



%--------------------------------------------------------------------------
% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Skalierungsfaktor Bildbereich 2 bestimmen:
%Größe Achsenbereich in Pixeln
AxesRect = get( handles.axes2, 'Position');
AxesWidth = AxesRect( 3);
AxesHeight = AxesRect( 4);
%Bildgröße
ImageWidth = size( handles.DisplayImageData, 2);
ImageHeight = size( handles.DisplayImageData, 1);
%Skalierungsfaktor je nach Hoch- oder Querformat
Factor = min( AxesWidth / ImageWidth, AxesHeight / AxesWidth);

%Anfangspunkt bestimmen
%Achsenkoordinaten
%Vorsicht: Y-Koordinate zählt in negativer Richtung (nach unten)
AxP1 = get( gca, 'CurrentPoint');           % button down detected
P1 = [ AxP1(1,1), -AxP1(1,2)];              % extract x and y, y negative

%Berechnung des Bildausschnitts in Fensterkoordinaten
%Anfangspunkt in Fensterkoordinaten
FigP1 = get( gcf, 'CurrentPoint');
%Statischer Offset zwischen Fenster- und Achsenkoordinaten
FigureOffset = FigP1 - P1*Factor;
%Bildausschnitt in Achsenkoordinaten
AxesImRect = handles.ImRect * Factor;
%Bildausschnitt in Fensterkoordinaten
%Rechteckgröße
FigureImRect = AxesImRect;
%Offset berücksichtigen
FigureImRect( 1) = AxesImRect( 1) + FigureOffset( 1);
FigureImRect( 2) = -AxesImRect( 2) + FigureOffset( 2) - AxesImRect( 4);

%Rechteck interaktiv bewegen
FinalRect = dragrect( FigureImRect);        % return figure units

%Endpunkt bestimmen
%Achsenkoordinaten
AxP2 = get(gca,'CurrentPoint');             % button up detected
P2 = [ AxP2(1,1), -AxP2(1,2)];

%Verschiebung in Pixelkoordinaten
Delta = (P2-P1);

%Bildausschnitt verschieben
ImRect = handles.ImRect;
ImRect( 1) = ImRect( 1) + Delta( 1);
ImRect( 2) = ImRect( 2) - Delta( 2);
%Verschiebung auf inneren Bildbereich begrenzen
ImRect( 1) = max( 1, min( ImageWidth - ImRect( 3), ImRect( 1)));
ImRect( 2) = max( 1, min( ImageHeight - ImRect( 4), ImRect( 2)));

%Bildausschnitt übernehmen und übergeben
handles.ImRect = ImRect;
guidata( hObject, handles);

%Neu zeichnen
updateView( handles);


%--------------------------------------------------------------------------
function ScalingFactor_Callback(hObject, eventdata, handles)
% hObject    handle to ScalingFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScalingFactor as text
%        str2double(get(hObject,'String')) returns contents of ScalingFactor as a double

%Benutzereingabe als String holen und in double konvertieren
User_entry = str2double( get( hObject, 'String'));
if isnan( User_entry)
    %Ungültige Eingabe
    errordlg( 'You must enter a numeric value','Bad Input','modal');
end
%Datum übernehmen und an Dialog übergeben
handles.ScalingFactor = User_entry;
guidata( hObject, handles);

%Anzeigen aktualisieren
updateView( handles);


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function ScalingFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScalingFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------------------------------------------------------------
% --- Executes on selection change in InterpolationPUM.
function InterpolationPUM_Callback(hObject, eventdata, handles)
% hObject    handle to InterpolationPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns InterpolationPUM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from InterpolationPUM

%Aktivierte Menüposition holen
Val = get( hObject, 'Value');

%Stringinfo als InterpolationMode übernehmen und an Dialog übergeben
String_list = get( hObject, 'String');
Selected_string = String_list{ Val}; % Convert from cell array to string
handles.InterpolationMode = Selected_string;
guidata( hObject, handles);


%--------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function InterpolationPUM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InterpolationPUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%set( hObject, 'String', 'nearest|bilinear|bicubic');
%set( hObject, 'Value', 2);


%--------------------------------------------------------------------------
function updateView( handles)
%Bildanzeigen, Pop-Up Menü, EditString und Infos im imResizerDialog zeichnen

%EditString:
myEditString = findobj( handles.imResizerFigure, 'Tag', 'ScalingFactor');
set( myEditString, 'String', num2str( handles.ScalingFactor));

%Popup Interpolation Mode:
myInterpModePUM = handles.InterpolationPUM;
myStringList = get( myInterpModePUM, 'String');
myListNr = findCellArrIndex( myStringList, handles.InterpolationMode);
if( ~isempty( myListNr))
    %Modus setzen
    set( myInterpModePUM, 'Value', myListNr);
else
    %gesetzter Mode ist nicht vorhanden:
    set( myInterpModePUM, 'Value', 1);
end

%Bildgröße als Rect einlesen
ImSizeRect = [ 1, 1, size( handles.DisplayImageData, 2), size( handles.DisplayImageData, 1)];

%Bildbereich 1 anzeigen
%sichtbarer Bereich Bildanzeige 1 (axes1)
XLim = get( handles.axes1,'xlim');
YLim = get( handles.axes1,'ylim');
%Graphikkanal auf Fenster und Bildbereich 1 (axes1) setzen
figure( handles.imResizerFigure); axes( handles.axes1);
% %Anzeige löschen 
% cla
%Bild setzen
ImageHandle = image( handles.DisplayImageData); 
%gleicher Maßstab in x und y
axis equal; 
%Achsen ausblenden
axis off; 
%Routine für Bildclicks setezen
set( ImageHandle, 'ButtonDownFcn', @Image1_ButtonDownFcn);
%Sichtbaren Bereich wieder setzen
set( handles.axes1,'xlim', XLim);
set( handles.axes1,'ylim', YLim);
%Bildausschnitt einzeichnen
if ~isequal( ImSizeRect, handles.ImRect)
    rectangle('Position', handles.ImRect, 'EdgeColor','y');
end

%Bildbereich 2 anzeigen
%Analog dassselbe wie für Bildbereich 1
axes( handles.axes2);
% cla
ImageHandle = image( handles.DisplayImageData); 
axis equal; axis off; 
set( ImageHandle, 'ButtonDownFcn', @Image2_ButtonDownFcn);
if ~isequal( ImSizeRect, handles.ImRect)
    rectangle('Position', handles.ImRect, 'EdgeColor','y');
end

%Informationen anzeigen:
%Infos bestimmen:
%Breite und Höhe
NewWidth = floor( handles.ImRect( 3) / handles.ScalingFactor);
NewHeight = floor( handles.ImRect( 4) / handles.ScalingFactor);
%Pixelanzahl
NewSize = NewWidth * NewHeight;
%Ausgabe als Static Text Felder
set( handles.WidthText, 'String', num2str( NewWidth));
set( handles.HeightText, 'String', num2str( NewHeight));
set( handles.SizeText, 'String', [num2str( NewSize / 1024 / 1024, 3), ' MPixel']);



