function [ theFileNamePlusPath, thePath, theExtension] = chooseFile4Read( theDialogTitle, theFilter, thePath)
% usage:                    theFileNamePlusPath = chooseFile4Read( theDialogTitle, theFilter, thePath)
% Beschreibung:             Auswahlbox zur Dateiauswahl Lesen
% theFileNamePlusPath:      vollständiger Dateiname inkl. Pfad
% theFilter:                Liste von Dateitypen, die angezeigt werden sollen, z.B. '*.tif'
% thePath:                  Default-Pfad, der eingestellt wird, wenn vorhanden

myWorkingDir = cd;
if( (strcmp( genpath( thePath), '') == 0) && (strcmp( thePath, '') == 0))
    cd( thePath);
end
[ myFileName, myTotPath] = uigetfile( theFilter, theDialogTitle);

cd( myWorkingDir);

if( myFileName == 0)
    theFileNamePlusPath = [];
	myTotPath = [];
else
    theFileNamePlusPath = fullfile( myTotPath, myFileName);
end %if

if nargout > 1
	thePath = myTotPath;
end

if nargout > 2 
	if ~isempty( theFileNamePlusPath)
		[ pathstr, name, ext] = fileparts( theFileNamePlusPath);
		theExtension = ext;
	else
		theExtension = [];		
end

end %chooseFile

