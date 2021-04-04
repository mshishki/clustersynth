function theRawImage = imreadRaw( theFilenamePlusPath)

myHomeDir = mfilename( 'fullpath');
%Ende bis einschl. letzten Slash löschen
while( myHomeDir(end)~='/' && myHomeDir(end)~='\')
	myHomeDir(end) = [];
end
myHomeDir(end) = [];


%dcraw aufrufen und tiff abspeichern
if ismac
	%Mac-Version
	system( [ myHomeDir, '/dcrawU -v -D -T -4 ', theFilenamePlusPath]);
else
	system( [ myHomeDir, '/dcraw-9.17-ms-64-bit.exe -v -D -T -4 ', theFilenamePlusPath]);
%	system( [ myHomeDir, '/dcraw.exe -v -D -T -4 ', myRawImageFileNames]);%dcraw-9.17-ms-64-bit
end

myTifFileName = [ theFilenamePlusPath( 1:end-3), 'tiff'];
theRawImage = imread (myTifFileName);

delete( myTifFileName);
