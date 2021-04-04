function [theRSpectrum, theGSpectrum, theBSpectrum, theRBSpectrum, theBRSpectrum, theGRSpectrum, theRGSpectrum, theBGSpectrum, theGBSpectrum, theRGXYZ, theGRXYZ, theDeltaE ] = Verkopplung4( theRGBData, theSpectralData, theYFactor, theXYZ_WP)


theRIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 85 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 170 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 225 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 255 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0);

theRSpectrum = theSpectralData( theRIndex, :);



theGIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 85 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 170 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 225 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 0);

theGSpectrum = theSpectralData( theGIndex, :);

     
theBIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 85 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 170 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 225 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 255);

theBSpectrum = theSpectralData( theBIndex, :);


theRGIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 85 & theRGBData( :, 2) == 85 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 170 & theRGBData( :, 2) == 170 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 225 & theRGBData( :, 2) == 225 & theRGBData( :, 3) == 0 ...
               | theRGBData( :, 1) == 255 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 0);
           
           
theRGSpectrum = theSpectralData( theRGIndex, :);

theGRSpectrum = theGSpectrum + theRSpectrum;

myXYZCurves = getXYZCurves_10nm();

n = 5;

for i = 1:n,
theRGXYZ(i, :) = theRGSpectrum( i, :) * myXYZCurves;
end

n = 5;

for i = 1:n,
theGRXYZ(i, :) = theGRSpectrum( i, :) * myXYZCurves;
end

theRGXYZ = theRGXYZ * theYFactor;
theGRXYZ = theGRXYZ * theYFactor;


theLabIst = imXYZ2Lab3( theRGXYZ, theXYZ_WP);


theLabSoll = imXYZ2Lab2( theGRXYZ, theXYZ_WP);


theDeltaE = getDeltaE2( theLabIst, theLabSoll);

theBGIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 85 & theRGBData( :, 3) == 85 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 170 & theRGBData( :, 3) == 170 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 225 & theRGBData( :, 3) == 225 ...
               | theRGBData( :, 1) == 0 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 255);
           

theBGSpectrum = theSpectralData( theBGIndex, :);

theGBSpectrum = theGSpectrum + theBSpectrum;


theRBIndex = find(theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0 ... 
               | theRGBData( :, 1) == 85 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 85 ...
               | theRGBData( :, 1) == 170 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 170 ...
               | theRGBData( :, 1) == 225 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 225 ...
               | theRGBData( :, 1) == 255 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 255);
           
           
theRBSpectrum = theSpectralData( theRBIndex, :);

theBRSpectrum = theBSpectrum + theRSpectrum;


figure();
hold on;
plot ( 380:10:730, theRGSpectrum, 'black' );
plot ( 380:10:730, theGRSpectrum, 'cyan' );
hold off;

figure();
hold on;
plot ( 380:10:730, theRBSpectrum, 'black' );
plot ( 380:10:730, theBRSpectrum, 'cyan' );
hold off;

figure();
hold on;
plot ( 380:10:730, theBGSpectrum, 'black' );
plot ( 380:10:730, theGBSpectrum, 'cyan' );
hold off;


