function [theR0Spectrum, theG0Spectrum, theB0Spectrum, theWhiteSpectrum] = analyzePrimariesSimple( theRGBData, theSpectralData)

%Rotspektrum bestimmen
myRedIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0);
theR0Spectrum = theSpectralData( myRedIndex, :);

%Grünspektrum bestimmen
myGreenIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 0);
theG0Spectrum = theSpectralData( myGreenIndex, :);

%Blauspektrum bestimmen
myBlueIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 255);
theB0Spectrum = theSpectralData( myBlueIndex, :);

%Weißspektrum bestimmen
myWhiteIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 255);
theWhiteSpectrum = theSpectralData( myWhiteIndex, :);

