function [ theFileNamePlusPath, thePath] = chooseFile4Write( theDialogTitle, theFilter, thePath)
% usage:                    theFileNamePlusPath = chooseFile4Write( theDialogTitle, theFilter, thePath)
% Beschreibung:             Auswahlbox zur Dateiauswahl Schreiben
% theFileNamePlusPath:      vollständiger Dateiname inkl. Pfad
% theFilter:                Liste von Dateitypen, die angezeigt werden sollen, z.B. '*.tif'
% thePath:                  Default-Pfad, der eingestellt wird, wenn vorhanden


myWorkingDir = cd;
if( ischar( thePath) && (strcmp( genpath( thePath), '') == 0) && (strcmp( thePath, '') == 0))
    cd( thePath);
end
[ myFileName, myTotPath] = uiputfile( theFilter, theDialogTitle);

cd( myWorkingDir);

if( myFileName == 0)
    theFileNamePlusPath = [];
else
    theFileNamePlusPath = fullfile( myTotPath, myFileName);
end %if

if nargout > 1
	thePath = myTotPath;
end

end %chooseFile

