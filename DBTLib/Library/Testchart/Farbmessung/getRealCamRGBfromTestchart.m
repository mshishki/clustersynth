function [theCamRGB, theWP] = getRealCamRGBfromTestchart( theFilename)
%Usage: [theCamRGB, theWP] = getRealCamRGBfromTestchart( theFilename);

%Simulation ausschalten:
myCamControl.fUseRGBfromMeasurement = 1;

myRGB_Raw = getCamRGBfromTestchart( theFilename, myCamControl);

%Weißabgleich
myRGB_WB = doWB_RGB( myRGB_Raw, myRGB_Raw( 45, :));

%RGB der inneren Patches holen:
theCamRGB = getInternalPatches( myRGB_WB);

if( nargout > 1)
	theWP = myRGB_Raw( 45, :);
end