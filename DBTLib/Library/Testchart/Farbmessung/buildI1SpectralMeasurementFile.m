function buildI1SpectralMeasurementFile( theProfileTextFileName, theFileInfo, theSpectralData, theRGBData)

% Neue Messdatei eröffnen und schreiben:
[pathstr,name,ext,versn] = fileparts( theProfileTextFileName);
if isempty( pathstr)
	myTotalFilename = which( theProfileTextFileName);
	[pathstr,name,ext,versn] = fileparts( myTotalFilename);
end
mySaveName = [ char( name), '_New.txt'];
myFID = fopen( [pathstr, '/', mySaveName], 'wt');

%Infos auspacken:
myFileHeader = theFileInfo.Header;
myFileEnd = theFileInfo.End;
myFilePatchesCol1 = theFileInfo.PatchesCol1;
myFilePatchesCol2 = theFileInfo.PatchesCol2;

%Header schreiben:
myNumHeaderRows = size( myFileHeader, 2);
for i=1:myNumHeaderRows
	fprintf( myFID, '%s\n', char( myFileHeader{ i}));
end

%Neue Patches schreiben:
help = myFilePatchesCol1;
mySpalte1 = char( help{ 1, 1});
help = myFilePatchesCol2;
mySpalte2 = char( help{ 1, 1});
myNumPatches = size( mySpalte1, 1);
for i=1:myNumPatches-1
	fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t\n', ...
		mySpalte1( i, :), mySpalte2( i, :), theRGBData( i, :), theSpectralData( i, :)); 
end
%Letzte Zeile separat schreiben, damit kein zusätzliches Linefeed:
i=myNumPatches;
fprintf( myFID, '%s\t%s\t%2.2f\t%2.2f\t%2.2f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t%2.4f\t', ...
		mySpalte1( i, :), mySpalte2( i, :), theRGBData( i, :), theSpectralData( i, :)); 

%Anhang schreiben
fwrite( myFID, myFileEnd);

fclose( myFID);
	