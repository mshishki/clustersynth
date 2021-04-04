function [theRSpectrum, theGSpectrum, theBSpectrum, theRBSpectrum, theBRSpectrum, theGRSpectrum, theRGSpectrum, theBGSpectrum, theGBSpectrum] = Verkopplung2( theRGBData, theSpectralData)


theRIndex = find(theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0);
theRSpectrum = theSpectralData( theRIndex, :);

theGIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 3) == 0);
theGSpectrum = theSpectralData( theGIndex, :);

theBIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0);
theBSpectrum = theSpectralData( theBIndex, :);



theRBIndex = find(theRGBData( :, 2) == 0);
theRBSpectrum = theSpectralData( theRBIndex, :);

theBRSpectrum = theBSpectrum + theRSpectrum;



theRGIndex = find( theRGBData( :, 3) == 0);
theRGSpectrum = theSpectralData( theRGIndex, :);

theGRSpectrum = theGSpectrum + theRSpectrum;



theBGIndex = find( theRGBData( :, 1) == 0);
theBGSpectrum = theSpectralData( theBGIndex, :);

theGBSpectrum = theGSpectrum + theBSpectrum;



figure();
hold on;
plot ( 380:10:730, theRBSpectrum, 'black' );
plot ( 380:10:730, theBRSpectrum, 'cyan' );
hold off;


figure();
hold on;
plot ( 380:10:730, theRGSpectrum, 'black' );
plot ( 380:10:730, theGRSpectrum, 'cyan' );
hold off;


figure();
hold on;
plot ( 380:10:730, theBGSpectrum, 'black' );
plot ( 380:10:730, theGBSpectrum, 'cyan' );
hold off;
