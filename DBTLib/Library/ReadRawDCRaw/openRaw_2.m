function theRawImage = openRaw_2( theFilename)

system( ['dcraw.exe -v -4 -D -T ', theFilename]);
myDateinameZwischenbild = [theFilename( 1:end-3), 'tiff'];
theRawImage = imread (myDateinameZwischenbild);

delete( myDateinameZwischenbild);
