function theAlgoResize = algoResize_new()
%Input: 
%Input( 1): ImageObject: ImageType, ImageData

theAlgoResize = algo_new( 'Resize');

theAlgoResize.FuncPtr.getSettings = @algoResize_getSettings;
theAlgoResize.FuncPtr.controldialog = @algoResize_controldialog;

theAlgoResize.FuncPtr.getInputTypeList = @algoResize_getInputTypeList;

theAlgoResize.FuncPtr.execute = @algoResize_execute;

theAlgoResize.Data.InputType = 0;
theAlgoResize.Data.OutputType = 0;


function theResizeSettings = algoResize_getSettings( theAlgoControl)

ResizeControl = theAlgoControl.Resize;
if strcmp( ResizeControl.Mode, 'Image')
    ResizeSettings.RelativeCropRect = [ 0, 0, 1, 1];
    ResizeSettings.CropRect = [];
    ResizeSettings.Size = ResizeControl.Size;
    ResizeSettings.Method = ResizeControl.Method;
elseif strcmp( ResizeControl.Mode, 'ROI')
    ResizeSettings.CropRect = ResizeControl.CropRect;
    %pixelgenau: einer zu viel -> korrigieren:
    ResizeSettings.CropRect( 3) = ResizeControl.CropRect( 3) - 1;
    ResizeSettings.CropRect( 4) = ResizeControl.CropRect( 4) - 1;

    ResizeSettings.RelativeCropRect = [];
    ResizeSettings.Size = ResizeControl.Size;
    ResizeSettings.Method = ResizeControl.Method;
end
    
theResizeSettings.Settings = ResizeSettings;


function theFigureHandle = algoResize_controldialog( theTaskHandle)

myInput = getInput( theTaskHandle);

myImageObject = findObject( myInput, 'Image', 'Input');
theFigureHandle = imResizer( theTaskHandle, getSettings( theTaskHandle), myImageObject);


function theInputTypeList = algoResize_getInputTypeList()

theInputTypeList( 1) = {[ {'Image'}, ...
                         {'RGB'}, ...
                         {'Lin_RGB'}, ...
                         {'sRGB'}, ...
                         {'sRGBLinear'}, ...
                         {'AdobeRGB'}, ...
                         {'AdobeRGBLinear'}...
                         ]};


function theAlgoResizeOut = algoResize_execute( theAlgoResizeIn, theSettings, theInput)
theAlgoResizeOut = theAlgoResizeIn;

[ Ymax, Xmax, Colors] = size( theInput.Input(1).Input.Data.ImageData);
% [ Ymax, Xmax, Colors] = size( theInput.Input(1).Data.ImageData);
if ~isempty( theSettings.Settings.RelativeCropRect)
    StartX = theSettings.Settings.RelativeCropRect( 1) * (Xmax - 1) + 1;
    StartY = theSettings.Settings.RelativeCropRect( 2) * (Ymax - 1) + 1;
    WidthX = theSettings.Settings.RelativeCropRect( 3) * (Xmax);
    WidthY = theSettings.Settings.RelativeCropRect( 4) * (Ymax);
    theSettings.Settings.CropRect = [ StartX, StartY, WidthX, WidthY];
end

%Elemente kopieren
theAlgoResizeOut.Data.Output.Output( 1).Output = theInput.Input(1).Input;
% theAlgoResizeOut.Data.Output.Output( 1).Output = theInput.Input(1);

%Bildausschnitt
CroppedImage = imcrop( theInput.Input(1).Input.Data.ImageData, theSettings.Settings.CropRect);
%Umskalierung
theAlgoResizeOut.Data.Output.Output( 1).Output.Data.ImageData = imresize( CroppedImage, [ theSettings.Settings.Size( 2), theSettings.Settings.Size( 1)], theSettings.Settings.Method);
%Dateiname ändern
theAlgoResizeOut.Data.Output.Output( 1).Output.Data.FileName = getTaskName( theAlgoResizeOut);

% %Elemente kopieren
% theAlgoResizeOut.Data.Output.Output( 1) = theInput.Input(1);
% 
% %Bildausschnitt
% CroppedImage = imcrop( theInput.Input(1).Data.ImageData, theSettings.Settings.CropRect);
% %Umskalierung
% theAlgoResizeOut.Data.Output.Output( 1).Data.ImageData = imresize( CroppedImage, [ theSettings.Settings.Size( 2), theSettings.Settings.Size( 1)], theSettings.Settings.Method);
% %Dateiname ändern
% theAlgoResizeOut.Data.Output.Output( 1).Data.FileName = getTaskName( theAlgoResizeOut);

%theAlgoResizeOut.Data.Output.Output( 1).Type = theInput.Input(1).Type;
