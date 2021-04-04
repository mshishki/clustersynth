function theDemosaickedImage = getDemosaickedRaw( theRawImage, theFilename)

myWD = pwd();
[myPath, myName, myExt, myVer] = fileparts( theFilename);
myImageName = [ myName, myExt];
if strcmp( myPath, myWD)==0
    %fremdes Verzeichnis:
    copyfile( 'dcraw.exe', myPath);
    fDel = 1;
else
    fDel = 0;
end

cd( myPath);

myDateinameZwischenbild = ['1', myImageName, '_raw.ppm'];
myDateinameZwischenbildPgm = ['1', myImageName, '_raw.pgm'];
imwrite( theRawImage, myDateinameZwischenbildPgm, 'pgm');
movefile( myDateinameZwischenbildPgm, myDateinameZwischenbild);

% Demosaicking rechnen
system( ['dcraw.exe -v -y -4 -o 0 ', myImageName]);
theDemosaickedImage = imread( [myImageName( 1:end-3), 'ppm']);

delete( [myImageName( 1:end-3), 'ppm']);
delete( myDateinameZwischenbild);

if fDel
    delete( 'dcraw.exe');
end

cd( myWD);
