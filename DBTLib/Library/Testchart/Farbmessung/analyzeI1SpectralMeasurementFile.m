function [ theFileInfo, theSpectralData, theRGBData] = analyzeI1SpectralMeasurementFile( theProfileTextFileName)

% Messdatei einlesen:

%Messdatei auswählen, falls nicht übergeben:
if ( ~exist( 'theProfileTextFileName') || isempty( theProfileTextFileName))
	% Textfile einlesen:
	[file, path] = uigetfile( '*.txt', 'Wähle eine Messdatei:');
	theProfileTextFileName = [path, file];
end
myFID = fopen( theProfileTextFileName, 'r');

%----------------------------------
%Header lesen:
myData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
while( strcmp( 'BEGIN_DATA', myData{ i})==0)
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
myHeaderEnd_i = i;

%----------------------------------
%Patches einlesen:
%Anzahl der Patches auslesen:
if( strncmp( 'NUMBER_OF_SETS', myData{ myHeaderEnd_i-1}, 14)==1)
	 myHelp = sscanf( char( myData{ myHeaderEnd_i-1}), '%s %f');
	 myNumPatches = myHelp( end);
else
	error( 'File Header failed. No NUMBER_OF_SETS found.');
end

%Textdatei mit Spektralwerten!!!
myFilePatches = textscan( myFID, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f ', myNumPatches);

%Anhang lesen:
%----------------------------------
[ myFileEnd, myNumEnd] = fread( myFID);

fclose( myFID);

%Daten aufbereiten (Arrays):
myRGBOldData = cell2mat( myFilePatches( 1, 3:5));
mySpectralData = cell2mat( myFilePatches( 1, 6:41)); %41: Hier geändert!!!

theFileInfo.Header = myData;
theFileInfo.End = myFileEnd;
theFileInfo.PatchesCol1 = myFilePatches( 1, 1);
theFileInfo.PatchesCol2 = myFilePatches( 1, 2);
if nargout>1
	theSpectralData = mySpectralData;
end
if nargout>2
	theRGBData = myRGBOldData;
end

