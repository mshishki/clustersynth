function theRawImage = openRaw( theFilename)

system( ['dcraw.exe -v -4 -o 0 ', theFilename]);
myDateinameZwischenbild = ['1', theFilename, '_raw.ppm'];
theRawImage = imread (myDateinameZwischenbild);

delete( myDateinameZwischenbild);
