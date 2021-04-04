function [ theRawImage, theMetaData] = imreadRawByDNG( theFilenamePlusPath)

myHomeDir = mfilename( 'fullpath');
%Ende bis einschl. letzten Slash löschen
while( myHomeDir(end)~='/' && myHomeDir(end)~='\')
	myHomeDir(end) = [];
end
myHomeDir(end) = [];

[ myPath, myFilename, myExt] = fileparts( theFilenamePlusPath);

% dngConverterPath=[ myHomeDir, '/"AdobeDNGConverter"'];
dngConverterPath=['/Applications/"Adobe DNG Converter.app"/'...
				  'Contents/MacOS/"Adobe DNG Converter" '];

myOptions = [ ' -u -d ', myPath, ' -o "' myFilename, '.dng"', ' "' theFilenamePlusPath, '"'];

%DNG-Konverter aufrufen und dng abspeichern
if ismac
	%Mac-Version
	system( [ dngConverterPath, myOptions]);
	
	if strcmp( lower( myExt), '.dng')
		%Ist bereits als dng vorhanden > Name_1 ändern!
		myDngFile = [ myPath, '/', myFilename, '_1.dng'];
	else
		myDngFile = [ myPath, '/', myFilename, '.dng'];
	end
	
else
	system( [ myHomeDir, '/dcraw-9.17-ms-64-bit.exe -v -D -T -4 ', theFilenamePlusPath]);
%	system( [ myHomeDir, '/dcraw.exe -v -D -T -4 ', myRawImageFileNames]);%dcraw-9.17-ms-64-bit
end

[ theRawImage, theMetaData] = readDngFile( myDngFile, 'raw' );


delete( myDngFile);
