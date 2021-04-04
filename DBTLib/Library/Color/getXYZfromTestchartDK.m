function theXYZ = getXYZfromTestchartDK( theFilename, theIlluminant, theWhitePatch)

mySpectra = getSpectraIE( theFilename);

switch theIlluminant
	case 'D50'
		myIllumination = getD50();
	case 'D65'
		myIllumination = getD65();
	case 'NLA'
		myIllumination = getNLA();
	otherwise
		myIllumination = getD50();
		myIlluminantion( :) = 1;
end

myXYZCurves = getXYZCurves_10nm();

myXYZCurvesXmyIllumination = myXYZCurves .* (myIllumination * [1, 1, 1]);

myXYZ_Raw = mySpectra * myXYZCurvesXmyIllumination;
%Weiﬂabgleich
if exist( 'theWhitePatch') && ~isempty( theWhitePatch)
	myXYZ = myXYZ_Raw/myXYZ_Raw(theWhitePatch, 2) *100;
else
	myY_W = sum( myXYZCurvesXmyIllumination( :, 2));
	myXYZ = myXYZ_Raw/myY_W *100;
end

theXYZ = getInternalPatches( myXYZ);
