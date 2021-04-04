function [ theXYZ_Sim, theXYZ_Real] = compareRGB2XYZFromTC( theXYZOrig, theXYZOrigWhite, theRGBReal, theWPIndex, theWhitepointFactor, theColorMatrix, theAdditiveTitle)

if exist( 'theAdditiveTitle', 'var') && ~isempty( theAdditiveTitle)
	myAdditiveTitle = theAdditiveTitle;	
else
	myAdditiveTitle = '';	%default 
end

%WB für RGBReal
myRGBRealWB( :, 1) = theRGBReal( :, 1) / (theRGBReal( theWPIndex, 1) * theWhitepointFactor( 1));
myRGBRealWB( :, 2) = theRGBReal( :, 2) / (theRGBReal( theWPIndex, 2) * theWhitepointFactor( 2));
myRGBRealWB( :, 3) = theRGBReal( :, 3) / (theRGBReal( theWPIndex, 3) * theWhitepointFactor( 3));

%XYZ umwandeln
myXYZReal = myRGBRealWB * theColorMatrix';

myXYZWhite = [ 1, 1, 1] * theColorMatrix';

%Genauigkeit prüfen
%Lab transformieren und mit Originalfarben vergleichen:
myOrigLab = imXYZ2Lab( theXYZOrig, theXYZOrigWhite);
myRealLab = imXYZ2Lab( myXYZReal, myXYZWhite);
LabEvaluationIE( myRealLab, myOrigLab, myAdditiveTitle);

if nargout>0
	theXYZ_Sim = myXYZSim;
end
if nargout>1
	theXYZ_Real = myXYZReal;
end
