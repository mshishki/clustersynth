function [ theXYZ_Orig, theXYZ_CM] = checkColorMatrixFromRGB( theColorMatrix, theRGB_WB, ...
													theSpectra, theIllumination4XYZ, theXYZWhite)
%XYZ abtasten
myXYZ_Original = simXYZfromSpectra( theSpectra, theIllumination4XYZ);
if exist( 'theXYZWhite', 'var') && ~isempty( theXYZWhite)
	myXYZWhite = theXYZWhite;
else
	myXYZWhite = simXYZfromSpectra( getWhiteSpectrum( theSpectra), theIllumination4XYZ);
end

%Farbkorrektur anwenden
myXYZ_CM = theRGB_WB * theColorMatrix';

%Genauigkeit prüfen
%Lab transformieren und mit Originalfarben vergleichen:
myOriginalLab = imXYZ2Lab( myXYZ_Original, myXYZWhite);
myCMLab = imXYZ2Lab( myXYZ_CM, myXYZWhite);
LabEvaluationIE( myCMLab, myOriginalLab, 'RGB optimized');

theXYZ_Orig = myXYZ_Original;
theXYZ_CM = myXYZ_CM;
