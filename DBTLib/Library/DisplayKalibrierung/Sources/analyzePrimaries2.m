function [theRGB2XYZMatrix, theXYZ_WP, theXYZ_BP, myYFactor] = analyzePrimaries2( theRGBData, theSpectralData, theProfileDir, theFBlackSubtraction)

myXYZCurves = getXYZCurves_10nm();

%Weiﬂpunkt bestimmen
myWhiteIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 255);
myWhiteSpectrum = theSpectralData( myWhiteIndex, :);

%Schwarzpunkt bestimmen
myBlackIndex = find( theRGBData( :, 1) == 0 & theRGBData( :, 2) == 0 & theRGBData( :, 3) == 0);
myBlackSpectrum = theSpectralData( myBlackIndex, :);


if theFBlackSubtraction == 1
	%Schwarzpunktabzug
	theXYZ_WP = (myWhiteSpectrum-myBlackSpectrum) * myXYZCurves;
	myYFactor = 100 / theXYZ_WP( 2);
	theXYZ_WP = theXYZ_WP * myYFactor;

	for i=1:size( theSpectralData, 1)
		theSpectralData( i, :) = theSpectralData( i, :) - myBlackSpectrum( :)';
	end
	
	myStartIndex = 2;%beim Farbkeil
else
	theXYZ_WP = myWhiteSpectrum * myXYZCurves;
	myYFactor = 100 / theXYZ_WP( 2);
	theXYZ_WP = theXYZ_WP * myYFactor;
	
	myStartIndex = 1;
end

theXYZ_BP = myBlackSpectrum * myXYZCurves * myYFactor;

%R-Kanal
[myScaleR, myScaleSpectraR, myScaleIndicesR] = analyzeChannel( theRGBData, theSpectralData, 1);
myMaxSpectrumR = myScaleSpectraR( end, :);
theXYZ_R = (myMaxSpectrumR) * myXYZCurves;
theXYZ_R = theXYZ_R * myYFactor;

%G-Kanal
[myScaleG, myScaleSpectraG, myScaleIndicesG] = analyzeChannel( theRGBData, theSpectralData, 2);
myMaxSpectrumG = myScaleSpectraG( end, :);
theXYZ_G = (myMaxSpectrumG) * myXYZCurves;
theXYZ_G = theXYZ_G * myYFactor;

%B-Kanal
[myScaleB, myScaleSpectraB, myScaleIndicesB] = analyzeChannel( theRGBData, theSpectralData, 3);
myMaxSpectrumB = myScaleSpectraB( end, :);
theXYZ_B = (myMaxSpectrumB) * myXYZCurves;
theXYZ_B = theXYZ_B * myYFactor;


theRGB2XYZMatrix = [ theXYZ_R', theXYZ_G', theXYZ_B'];

plot1D3RGB( [myMaxSpectrumR(:), myMaxSpectrumG(:), myMaxSpectrumB(:)], 380:10:730, 'MaxSpectra');

myChromaticityChartFigure = showPrimariesDiagram( myMaxSpectrumR, myMaxSpectrumG, myMaxSpectrumB, 'Primaries', 1);
showPrimaries( myScaleSpectraR( myStartIndex:end, :), 'r', 0);
showPrimaries( myScaleSpectraG( myStartIndex:end, :), 'g', 0);
showPrimaries( myScaleSpectraB( myStartIndex:end, :), 'b', 0);
DrawSpectralCurve( myChromaticityChartFigure);
myMatrix = getTrafoMatrixFromLinProfiles( [ theProfileDir, 'sRGBLinear.icc'], '*XYZ');
DrawRGBTriangle( myChromaticityChartFigure, myMatrix, 'm');
myMatrix = getTrafoMatrixFromLinProfiles( [ theProfileDir, 'AdobeRGBLinear.icc'], '*XYZ');
DrawRGBTriangle( myChromaticityChartFigure, myMatrix, 'c');
