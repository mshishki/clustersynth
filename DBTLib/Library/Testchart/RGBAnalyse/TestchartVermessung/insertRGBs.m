function insertRGBs( theProfileTextFileName, thePatchesResult, theFDoFlareCorrection)

% Messdatei einlesen:

%Messdatei auswählen, falls nicht übergeben:
if ( (exist( 'theProfileTextFileName') == 0) || theProfileTextFileName ==0)
	% Textfile einlesen:
	[file, path] = uigetfile( '*.txt', 'Wähle eine I1 Messdatei:');
	theProfileTextFileName = [path, file];
end
myFID = fopen( theProfileTextFileName, 'r');

%Header lesen:
myData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
while( strcmp( 'BEGIN_DATA', myData{ i})==0)
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
myHeaderEnd_i = i;

%Anzahl der Patches auslesen:
if( strncmp( 'NUMBER_OF_SETS', myData{ myHeaderEnd_i-1}, 14)==1)
	 myHelp = sscanf( char( myData{ myHeaderEnd_i-1}), '%s %f');
	 myNumPatches = myHelp( end);
else
	error( 'File Header failed. No NUMBER_OF_SETS found.');
end

%Patches einlesen:
myFilePatches = textscan( myFID, '%s %s %f %f %f %f %f %f %f %f %f ', myNumPatches);

%Anhang lesen:
[ myFileEnd, myNumEnd] = fread( myFID);

fclose( myFID);

%Daten aufbereiten (Arrays):
myRGBData = cell2mat( myFilePatches( 1, 3:5));
myXYZData = cell2mat( myFilePatches( 1, 6:8));
myLabData = cell2mat( myFilePatches( 1, 9:11));

%Neue RGB-Daten lesen/übernehmen:
if ( (exist( 'thePatchesResult') == 0) || thePatchesResult ==0)
	[ myRGBNewData, thePatchesResult] = getRGBs( 0);  % Profilemaker braucht 8bit Daten
else
	[ myRGBNewData, thePatchesResult] = getRGBs( thePatchesResult);  % Profilemaker braucht 8bit Daten
end
myRGBMaxValue = thePatchesResult.Control.Testchart.MaxValue;

%Zu Testzwecken:
% myRGBNewData = myRGBData;
% myRGBMaxValue = 255;

% % Auswahl der Graukeilstufen
% grey = [ 46, 95, 56, 85, 66, 75, 76, 65, 86, 55, 96, 45 ];
% 
% myYGrey = myXYZData( grey( :), 2)/myXYZData( grey( end), 2)*thePatchesResult.Control.Testchart.MaxValue;
% myCameraGrey = [ myRGBNewData( grey( :), 1)/myRGBNewData( grey( end), 1)*thePatchesResult.Control.Testchart.MaxValue, ...
% 				myRGBNewData( grey( :), 2)/myRGBNewData( grey( end), 2)*thePatchesResult.Control.Testchart.MaxValue, ...
% 				myRGBNewData( grey( :), 3)/myRGBNewData( grey( end), 3)*thePatchesResult.Control.Testchart.MaxValue];
% 
% analyze1D( myYGrey, myCameraGrey, 'RGBCam = f( Y_i1)')
% 
% % Streulichtkorrektur
% if ( (exist( 'theFDoFlareCorrection') == 0) || theFDoFlareCorrection == -1)
% 	% Abfrage per Dialog:
% 	button = questdlg('Do flare correction?');
% 	if button == 'Yes'
% 		theFDoFlareCorrection = 1;
% 	else
% 		theFDoFlareCorrection = 0;
% 	end
% end
% 
% if( theFDoFlareCorrection)
% 	% Streulichtkorrektur (Korrekturfunktion)
% 	myFlareLuts = computeFlareLuts( myYGrey, myCameraGrey);
% 	myRGBNewData( :, 1) = myFlareLuts( uint32( myRGBNewData( :, 1)/myRGBMaxValue*(2^16-1)+1), 1);
% 	myRGBNewData( :, 2) = myFlareLuts( uint32( myRGBNewData( :, 2)/myRGBMaxValue*(2^16-1)+1), 2);
% 	myRGBNewData( :, 3) = myFlareLuts( uint32( myRGBNewData( :, 3)/myRGBMaxValue*(2^16-1)+1), 3);
% end

%Normierung auf 8 bit für den Profilemaker:
myRGBNewData_uint8 = myRGBNewData*255/myRGBMaxValue;

% Neue Messdatei eröffnen und schreiben:
[pathstr,name,ext,versn] = fileparts( theProfileTextFileName);
mySaveName = [ char( name), '_New.txt'];
myFID = fopen( [pathstr, '/', mySaveName], 'wt');

%Header schreiben:
for i=1:myHeaderEnd_i
	fprintf( myFID, '%s\n', char( myData{ i}));
end

%Neue Patches schreiben:
help = myFilePatches( 1, 1);
mySpalte1 = char( help{ 1, 1});
help = myFilePatches( 1, 2);
mySpalte2 = char( help{ 1, 1});
for i=1:myNumPatches-1
	fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t\n', ...
		mySpalte1( i, :), mySpalte2( i, :), myRGBNewData_uint8( i, 1), myRGBNewData_uint8( i, 2), myRGBNewData_uint8( i, 3), ...
		myXYZData( i, 1), myXYZData( i, 2), myXYZData( i, 3), ...
		myLabData( i, 1), myLabData( i, 2), myLabData( i, 3)); 
end
%Letzte Zeile separat schreiben, damit kein zusätzliches Linefeed:
i=myNumPatches;
fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t%2.2f\t', ...
		mySpalte1( i, :), mySpalte2( i, :), myRGBNewData_uint8( i, 1), myRGBNewData_uint8( i, 2), myRGBNewData_uint8( i, 3), ...
		myXYZData( i, 1), myXYZData( i, 2), myXYZData( i, 3), ...
		myLabData( i, 1), myLabData( i, 2), myLabData( i, 3)); 

%Anhang schreiben
fwrite( myFID, myFileEnd);

fclose( myFID);
	
