function [ theFileInfo, theRGBData] = analyzePMDisplayControlFile( theDispControlFileName)

% Messdatei einlesen:

%Messdatei auswählen, falls nicht übergeben:
if ( ~exist( 'theDispControlFileName') || isempty( theDispControlFileName))
	% Textfile einlesen:
	[file, path] = uigetfile( '*.txt', 'Wähle eine Display-Control-Datei:');
	theDispControlFileName = [path, file];
end
myData = readStringRows( theDispControlFileName);

myFID = fopen( theDispControlFileName, 'r');

%----------------------------------
%Header lesen:
myData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
while( isempty( strfind( cell2mat( myData{ i}), 'BEGIN_DATA_FORMAT')))
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
while( isempty( strfind( cell2mat( myData{ i}), 'BEGIN_DATA')))
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
myHeaderEnd_i = i;

%----------------------------------
%Patches einlesen:

myControlData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
%Patches auslesen:
while( isempty( strfind( cell2mat( myControlData{ i}), 'END_DATA')))
	i = i+1;
	myControlData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end

%Textdatei auswerten
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

