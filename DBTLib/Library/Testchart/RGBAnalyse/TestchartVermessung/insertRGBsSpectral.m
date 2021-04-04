function insertRGBsSpectral( theProfileTextFileName, thePatchesResult, theMaxValue, theFDoFlareCorrection)

myRGBMaxValue = theMaxValue;

% Messdatei einlesen:
[ myFileInfo, mySpectralData] = analyzeI1SpectralMeasurementFile( theProfileTextFileName);
% %Messdatei auswählen, falls nicht übergeben:
% if ( ~exist( 'theProfileTextFileName') || isempty( theProfileTextFileName))
% 	% Textfile einlesen:
% 	[file, path] = uigetfile( '*.txt', 'Wähle eine Messdatei:');
% 	theProfileTextFileName = [path, file];
% end
% myFID = fopen( theProfileTextFileName, 'r');
% 
% %----------------------------------
% %Header lesen:
% myData = textscan( myFID, '%s', 1, 'delimiter', '\n');
% i = 1;
% while( strcmp( 'BEGIN_DATA', myData{ i})==0)
% 	i = i+1;
% 	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
% end
% myHeaderEnd_i = i;
% 
% %----------------------------------
% %Patches einlesen:
% %Anzahl der Patches auslesen:
% if( strncmp( 'NUMBER_OF_SETS', myData{ myHeaderEnd_i-1}, 14)==1)
% 	 myHelp = sscanf( char( myData{ myHeaderEnd_i-1}), '%s %f');
% 	 myNumPatches = myHelp( end);
% else
% 	error( 'File Header failed. No NUMBER_OF_SETS found.');
% end
% 
% %Textdatei mit Spektralwerten!!!
% myFilePatches = textscan( myFID, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f ', myNumPatches);
% 
% %Anhang lesen:
% %----------------------------------
% [ myFileEnd, myNumEnd] = fread( myFID);
% 
% fclose( myFID);
% 
% %Daten aufbereiten (Arrays):
% myRGBOldData = cell2mat( myFilePatches( 1, 3:5));
% mySpectralData = cell2mat( myFilePatches( 1, 6:41)); %41: Hier geändert!!!

%Neue RGB-Daten lesen/übernehmen:
if ( ~exist( 'thePatchesResult') || isempty( thePatchesResult))
	[ myRGBNewData, thePatchesResult] = getRGBs( 0);  % Profilemaker braucht 8bit Daten
else
	[ myRGBNewData, thePatchesResult] = getRGBs( thePatchesResult);  % Profilemaker braucht 8bit Daten
end


% Auswahl der Graukeilstufen
grey = [ 46, 95, 56, 85, 66, 75, 76, 65, 86, 55, 96, 45 ];

myYGrey = (mean( mySpectralData( grey(:), :)'))' / mean( mySpectralData( grey( end), :)')*myRGBMaxValue;
myCameraGrey = [ myRGBNewData( grey( :), 1)/myRGBNewData( grey( end), 1)*myRGBMaxValue, ...
				myRGBNewData( grey( :), 2)/myRGBNewData( grey( end), 2)*myRGBMaxValue, ...
				myRGBNewData( grey( :), 3)/myRGBNewData( grey( end), 3)*myRGBMaxValue];

%Anzeige Soll/Ist
plot1D3Soll_Ist( myCameraGrey, myYGrey, 'RGBCam = f( Y_i1)');

% Streulichtkorrektur
if ( ~exist( 'theFDoFlareCorrection') || theFDoFlareCorrection == -1)
	% Abfrage per Dialog:
	button = questdlg('Do flare correction?');
	if strcmp( button, 'Yes')
		theFDoFlareCorrection = 1;
	else
		theFDoFlareCorrection = 0;
	end
end

if( theFDoFlareCorrection)
	% Streulichtkorrektur (Korrekturfunktion)
	myFlareLuts = computeFlareLuts( myYGrey, myCameraGrey);
	myRGBNewData( :, 1) = myFlareLuts( uint32( myRGBNewData( :, 1)/myRGBMaxValue*(2^16-1)+1), 1);
	myRGBNewData( :, 2) = myFlareLuts( uint32( myRGBNewData( :, 2)/myRGBMaxValue*(2^16-1)+1), 2);
	myRGBNewData( :, 3) = myFlareLuts( uint32( myRGBNewData( :, 3)/myRGBMaxValue*(2^16-1)+1), 3);
end

%Normierung auf 8 bit für den Profilemaker:
myRGBNewData_uint8 = myRGBNewData*255/myRGBMaxValue;

% Neue Messdatei eröffnen und schreiben:
buildI1SpectralMeasurementFile( theProfileTextFileName, myFileInfo, mySpectralData, myRGBNewData_uint8);


% [pathstr,name,ext,versn] = fileparts( theProfileTextFileName);
% if isempty( pathstr)
% 	myTotalFilename = which( theProfileTextFileName);
% 	[pathstr,name,ext,versn] = fileparts( myTotalFilename);
% end
% mySaveName = [ char( name), '_New.txt'];
% myFID = fopen( [pathstr, '/', mySaveName], 'wt');
% 
% %Header schreiben:
% myNumHeaderRows = size( myFileHeader, 2);
% for i=1:myNumHeaderRows
% 	fprintf( myFID, '%s\n', char( myFileHeader{ i}));
% end
% 
% %Neue Patches schreiben:
% help = myFilePatches( 1, 1);
% mySpalte1 = char( help{ 1, 1});
% help = myFilePatches( 1, 2);
% mySpalte2 = char( help{ 1, 1});
% for i=1:myNumPatches-1
% 	fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t\n', ...
% 		mySpalte1( i, :), mySpalte2( i, :), myRGBNewData_uint8( i, :), mySpectralData( i, :)); 
% end
% %Letzte Zeile separat schreiben, damit kein zusätzliches Linefeed:
% i=myNumPatches;
% fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t', ...
% 		mySpalte1( i, :), mySpalte2( i, :), myRGBNewData_uint8( i, :), mySpectralData( i, :)); 
% 
% %Anhang schreiben
% fwrite( myFID, myFileEnd);
% 
% fclose( myFID);
% 	
