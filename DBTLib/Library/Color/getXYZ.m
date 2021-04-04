function theXYZ = getXYZ( theSpectralData, theWhite)
myXYZCurves = getXYZCurves_10nm();
%XYZ-Kurven auf Gleichenergieweiﬂ normieren
myXYZCurves( :, 1) = myXYZCurves( :, 1) / sum( myXYZCurves( :, 1));
myXYZCurves( :, 2) = myXYZCurves( :, 2) / sum( myXYZCurves( :, 2));
myXYZCurves( :, 3) = myXYZCurves( :, 3) / sum( myXYZCurves( :, 3));

if exist( 'theWhite') && ~isempty( theWhite)
	myRawXYZ_White = theWhite * myXYZCurves;
	myYNorm = myRawXYZ_White( 2);
	myNormFactor = 100 / myYNorm;
	theXYZ = theSpectralData * myXYZCurves * myNormFactor;
else
	myNormFactor = 100;
	theXYZ = theSpectralData * myXYZCurves * myNormFactor;
end
