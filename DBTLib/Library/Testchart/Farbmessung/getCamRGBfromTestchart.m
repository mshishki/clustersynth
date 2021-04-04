function theCamRGB = getCamRGBfromTestchart( theFilename, theCamControl)
%Usage: theCamRGB = getCamRGBfromTestchart( theFilename, theCamControl);
%Hint: if theCamControl.fUseRGBfromMeasurement==1 -> all other entries of
%       theCamControl are ignored and obsolete

%I1 Spektraldaten und RGBs der Meßdatei laden
i1MeasurementData = getI1MeasurementData( theFilename);
[ SpectralData, RGBData] = getAllData( i1MeasurementData);

% %zu Testzwecken
% for i=1:8
%     SpectralData( 11+i, :) = SpectralData( 45, :)/i^2;
% end

if theCamControl.fUseRGBfromMeasurement==1
	myRGB = RGBData;
	%RGB Daten der S3 mit Streulichtkorrektur
% 	temp = load( 'ResultImageRGBCorrImage_FlareCorr_Richtig.mat');		%Aus Matlabgründen temp nochmals zuweisen.
% 	thePatchesResult = temp.TestchartResults;
% 	myRGB = getRGBs( thePatchesResult);

else
	%RGB-Simulation
	Illumination = getD50();
	RGBCurves10nm = getRGBSensitivities( theCamControl);
	myRGB = simRGBfromSpectra( SpectralData, Illumination, RGBCurves10nm);
end

theCamRGB = myRGB;