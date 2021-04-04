function [theRGB, theXYZ_Orig, theXYZ_CM] = checkColorMatrix( theColorMatrix, theSensitivities, ...
													theSpectra, theIllumination4RGB, ...
													theIllumination4XYZ, theXYZWhite)
%Für sinnvolle Ergebnisse ist theIllumination4XYZ auf die Lichtart zu
%setzen, auf die theColorMatrix optimiert wurde.

%XYZ abtasten
myXYZ_Original = simXYZfromSpectra( theSpectra, theIllumination4XYZ);
if exist( 'theXYZWhite', 'var') && ~isempty( theXYZWhite)
	myXYZWhite = theXYZWhite;
else
	myXYZWhite = simXYZfromSpectra( getWhiteSpectrum( theSpectra), theIllumination4XYZ);
end


%RGB abtasten
myRGB = simRGBfromSpectraWB( theSpectra, theIllumination4RGB, theSensitivities);

%Farbkorrektur anwenden
myXYZ_CM = myRGB * theColorMatrix';

%Genauigkeit prüfen
%Lab transformieren und mit Originalfarben vergleichen:
myOriginalLab = imXYZ2Lab( myXYZ_Original, myXYZWhite);
myCMLab = imXYZ2Lab( myXYZ_CM, myXYZWhite);
LabEvaluationIE( myCMLab, myOriginalLab, 'Spectrally optimized');

theRGB = myRGB;
theXYZ_Orig = myXYZ_Original;
theXYZ_CM = myXYZ_CM;
