function theRGBCurves10nm = getRGBSensitivities( theCamControl)

myWidthHalf = theCamControl.RGBWidth;

myDelta = 10;
myRIndex = theCamControl.WavelengthR/myDelta;
myGIndex = theCamControl.WavelengthG/myDelta;
myBIndex = theCamControl.WavelengthB/myDelta;

myWidthHalfIndex = myWidthHalf/myDelta;

myFunction = (1 + cos( (-myWidthHalfIndex: 1 : myWidthHalfIndex)/myWidthHalfIndex*pi)) / 2;

myCurves_1000 = zeros( 100, 3, 'double');
myRStart = myRIndex - myWidthHalfIndex;
myCurves_1000( myRStart:myRStart + 2*myWidthHalfIndex, 1) = myFunction( :);
myGStart = myGIndex - myWidthHalfIndex;
myCurves_1000( myGStart:myGStart + 2*myWidthHalfIndex, 2) = myFunction( :);
myBStart = myBIndex - myWidthHalfIndex;
myCurves_1000( myBStart:myBStart + 2*myWidthHalfIndex, 3) = myFunction( :);

myRGBCurves10nm = myCurves_1000( 38:73, :);

if theCamControl.fOrthoRGB ==1
	[myRGBCurvesOrtho, myOrthoMatrixRGB] = orthogonalize( myRGBCurves10nm);
	myRGBCurves10nm = myRGBCurvesOrtho;
end

theRGBCurves10nm = myRGBCurves10nm;