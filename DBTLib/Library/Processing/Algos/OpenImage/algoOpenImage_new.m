function theAlgoOpenImage = algoOpenImage_new()
%Input: 

theAlgoOpenImage = algo_new( 'OpenImage');

theAlgoOpenImage.FuncPtr.getSettings = @algoOpenImage_getSettings;
theAlgoOpenImage.FuncPtr.getInputTypeList = @algoOpenImage_getInputTypeList;
theAlgoOpenImage.FuncPtr.execute = @algoOpenImage_execute;



function theOpenImageSettings = algoOpenImage_getSettings( theAlgoControl)

theOpenImageSettings.Settings = theAlgoControl;



function theInputTypeList = algoOpenImage_getInputTypeList()

theInputTypeList = [];



function theAlgoOpenImageOut = algoOpenImage_execute( theAlgoOpenImageIn, theSettings, theInput)
theAlgoOpenImageOut = theAlgoOpenImageIn;

%Datei auswählen
FileName = chooseFile4Read( 'Select image:', ...
    {'*.dng;*.DNG','DNG Files (*.dng, *.DNG)';...   
    '*.tif;*.TIF','TIF Files (*.tif, *.TIF)'; 
    '*.jpg;*.JPG','JPG Files (*.jpg, *JPG)';...
    '*.gif;*.GIF','GIF Files (*.gif, *.GIF)';...
    '*.bmp;*.BMP','BMP Files (*.bmp, *.BMP)';...   
    '*.dng;*.DNG','DNG Files (*.dng, *.DNG)';...   
    '*.cr2;*.CR2','Canon Raw Files (*.cr2, *.CR2)';...   
    '*.nef;*.NEF','Nikon Raw Files (*.nef, *.NEF)';...   
    '*.raf;*.RAF','Fuji Raw Files (*.raf, *.RAF)';...   
    '*.*','All Files(*.*)'}, ...
    '');
if isempty( FileName)
    terminate();
end
[pathstr,name,ext,versn] = fileparts( FileName);
if (isequal(ext,'.tif') || isequal(ext,'.jpg') || isequal(ext,'.JPG')...
    || isequal(ext,'.TIF') || isequal(ext,'.BMP') || isequal(ext,'.GIF') ...
    || isequal(ext,'.bmp') || isequal(ext,'.gif'))
    %öffnen und einlesen Standardformate
    Image = imread( FileName);
else
    %CCD Rohbild einlesen, Dateinamen entgegennehmen
	Image = openRawImage( FileName);
end

if isempty( Image)
    %Eingaben ungültig
    theAlgoOpenImageOut = [];
    return;
end


%Bilddaten mit Zubehör installieren
ImageType = imgetType( Image, FileName);

theAlgoOpenImageOut.Data.Output.Output( 1).Output = new( 'dataImage', {Image, ImageType, FileName});
% theAlgoOpenImageOut.Data.Output.Output( 1) = new( 'dataImage', {Image, ImageType, FileName});

% ImageObject.ImageData = Image;
% ImageObject.ImageType = ImageType;
% ImageObject.FileName = FileName;
% ImageObject.Control = theSettings.Settings;
% 
% theAlgoOpenImageOut.Data.Output.Output( 1).Type = [ 'Image_', ImageType];
% theAlgoOpenImageOut.Data.Output.Output( 1).Data = ImageObject;
