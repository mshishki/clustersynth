function theCamSensitities = getCamSensitivitiesEstimate(  theMeasurementFileName);
% Alle Daten für das vermessene Testchart einlesen: RGB Kamera, XYZ i1, Spektraldaten i1, Lichtspektrum
myRGBOrig = getRealCamRGBfromTestchart( theMeasurementFileName);
[myXYZOrig, mySpectra, myIllum] = getXYZfromTestchartIE( theMeasurementFileName);

% Farbreizfunktionen bilden:
mySpectralFlux = getSpectralFluxfromSpectra( mySpectra, myIllum);

%%%%%%%%%%%%%%%%%%
% Empfindlichkeitsbestimmung
%%%%%%%%%%%%%%%%%%

% Spektrale Empfindlichkeiten der Kamera über die Wiener-Inverse bestimmen und anzeigen
%mySensitivitiesCam = estimateSensitivitiesIE( myRGBOrig, mySpectralFlux, 0.85);
myCovMatrixSens = getMarkovCovarianceMatrix( size( mySpectra, 2), 0.85);
myWI = inv( mySpectralFlux' * mySpectralFlux + inv( myCovMatrixSens)) * mySpectralFlux';
mySensitivitiesCam = myWI * myRGBOrig;

plot1D3Spectral( mySensitivitiesCam, 'Kameraempfindlichkeiten:');

theCamSensitities = mySensitivitiesCam;
