function theRGBCurves = getRGBSensitivitiesIE( theWavelenR, theWavelenG, theWavelenB, theWidth)
%Usage: theRGBCurves = getRGBSensitivitiesIE( theWavelenR, theWavelenG,
%                                               theWavelenB, theWidth);
myCamControl.WavelengthR = theWavelenR;
myCamControl.WavelengthG = theWavelenG;
myCamControl.WavelengthB = theWavelenB;
myCamControl.RGBWidth = theWidth;
myCamControl.fOrthoRGB = 0;
	
theRGBCurves = getRGBSensitivities( myCamControl);
