function theRawImage = openRaw_Demos( theFilename, theDcrawCommandLine)

global DcrawCommandLine

%system( ['dcraw.exe -v -4 -o 0 -T', theFilename]);
system( ['dcraw.exe ', theDcrawCommandLine, theFilename]);
myDateinameZwischenbild = [theFilename( 1:end-3), 'tiff'];
theRawImage = imread (myDateinameZwischenbild);

delete( myDateinameZwischenbild);
