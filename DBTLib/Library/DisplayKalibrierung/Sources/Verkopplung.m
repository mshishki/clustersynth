function [theRSpectrum, theGSpectrum, theBSpectrum, theRBSpectrum, theBRSpectrum] = Verkopplung( theRGBData, theSpectralData)


theRIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0);
theRSpectrum = theSpectralData( theRIndex, :);

theGIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 0);
theGSpectrum = theSpectralData( theGIndex, :);

theBIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 255);
theBSpectrum = theSpectralData( theBIndex, :);


theRBIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 255);
theRBSpectrum = theSpectralData( theRBIndex, :);


theBRSpectrum = theBSpectrum + theRSpectrum;



figure();
hold on;
plot ( 380:10:730, theRBSpectrum, 'black' );
plot ( 380:10:730, theBRSpectrum, 'cyan' );
hold off;