function [ theRawImage, theMetaData] = imreadRawByDNG( theFilenamePlusPath)
% Funktion liest die Rohbilddatei theFilenamePlusPath ein und liefert ihre
% Rohbilddaten theRawImage und ihre Metadaten theMetaData zurück.

if ~strcmp( theFilenamePlusPath( (end-3):end), '.dng')
	%Datei noch nicht konvertiert vorhanden -> dng-konvertieren!

	myHomeDir = mfilename( 'fullpath');
	%Ende bis einschl. letzten Slash löschen
	while( myHomeDir(end)~='/' && myHomeDir(end)~='\')
		myHomeDir(end) = [];
	end
	myHomeDir(end) = [];

	[ myPath, myFilename, myExt] = fileparts( theFilenamePlusPath);

	myOptions = [ ' -u -d ', [ '', path4syscall( myPath), ''], ' -o ', myFilename, ...
					'.dng', ' ', path4syscall( theFilenamePlusPath)];

	%DNG-Konverter aufrufen und dng abspeichern
	if ismac
		%Mac-Version
		dngConverterPath1=['/Applications/"Adobe DNG Converter.app"/'...
					  'Contents/MacOS/"Adobe DNG Converter" '];
		dngConverterPath2=[''];
	else
		dngConverterPath1 = [ 'C:\"Program Files"\Adobe\"Adobe DNG Converter.exe"'];
		dngConverterPath2 = [ 'C:\"Program Files (x86)"\Adobe\"Adobe DNG Converter.exe"'];
	end

	%System-Call 
	%Versuch mit Path1
	if system( [ dngConverterPath1, myOptions]) ~= 0
		%2. Versuch mit Path2
		system( [ dngConverterPath2, myOptions]);
	end

	% Bild- und Metadaten einlesen
	if strcmp( lower( myExt), '.dng')
		%Ist bereits als dng vorhanden > Name_1 ändern!
		myDngFile = [ myPath, '/', myFilename, '_1.dng'];
	else
		myDngFile = [ myPath, '/', myFilename, '.dng'];
	end
	[ theRawImage, theMetaData] = readDngFile( myDngFile, 'raw' );

	%DNG wieder löschen, wenn neues File erzeugt
	%if ~strcmp( lower( myExt), '.dng')
		delete( myDngFile);
	%end
else
	%Datei bereits konvertiert vorhanden
	[ theRawImage, theMetaData] = readDngFile( theFilenamePlusPath, 'raw' );
end
