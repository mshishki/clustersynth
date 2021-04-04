function [ theXYZ_Sim, theXYZ_Real] = compareRGBFromTC( theRGBSim, theRGBReal, theWPIndex, theWhitepointFactor, theColorMatrix, theAdditiveTitle)

if exist( 'theAdditiveTitle', 'var') && ~isempty( theAdditiveTitle)
	myAdditiveTitle = theAdditiveTitle;	
else
	myAdditiveTitle = '';	%default 
end

%WB für RGBSim
myRGBSimWB( :, 1) = theRGBSim( :, 1) / (theRGBSim( theWPIndex, 1) * theWhitepointFactor( 1));
myRGBSimWB( :, 2) = theRGBSim( :, 2) / (theRGBSim( theWPIndex, 2) * theWhitepointFactor( 2));
myRGBSimWB( :, 3) = theRGBSim( :, 3) / (theRGBSim( theWPIndex, 3) * theWhitepointFactor( 3));

%WB für RGBReal
myRGBRealWB( :, 1) = theRGBReal( :, 1) / (theRGBReal( theWPIndex, 1) * theWhitepointFactor( 1));
myRGBRealWB( :, 2) = theRGBReal( :, 2) / (theRGBReal( theWPIndex, 2) * theWhitepointFactor( 2));
myRGBRealWB( :, 3) = theRGBReal( :, 3) / (theRGBReal( theWPIndex, 3) * theWhitepointFactor( 3));

%XYZ umwandeln
myXYZSim = myRGBSimWB * theColorMatrix';
myXYZReal = myRGBRealWB * theColorMatrix';

myXYZWhite = [ 1, 1, 1] * theColorMatrix';


%Genauigkeit prüfen
%Lab transformieren und mit Originalfarben vergleichen:
mySimLab = imXYZ2Lab( myXYZSim, myXYZWhite);
myRealLab = imXYZ2Lab( myXYZReal, myXYZWhite);
LabEvaluationIE( myRealLab, mySimLab, myAdditiveTitle);

if nargout>0
	theXYZ_Sim = myXYZSim;
end
if nargout>1
	theXYZ_Real = myXYZReal;
end
