close all hidden;

%%%%%%%%%%%%%%%%%%
% Initialisierung
%%%%%%%%%%%%%%%%%%

mySensitivitiesCam = getCamSensitivitiesEstimate(  'digColorCheckerSG_eye1_spektral.txt');
myIllum = getD50();

%Optimierungsdatensatz:
mySpectra = getSpectraIE( 'AllMinusKrinov');
myWhitePatch = 1578;
% mySpectra = getInternalPatches( getSpectraIE( 'digColorCheckerSG_eye1_spektral.txt'));
% myWhitePatch = 28;


% Spektralabtastung mit den gefundenen Empfindlichkeiten simulieren:
myRGBSim = simRGBfromSpectra( mySpectra, myIllum, mySensitivitiesCam);
myIntensity = myRGBSim( :, 1) + myRGBSim( :, 2) + myRGBSim( :, 3);
mySpectraNorm = mySpectra ./ (myIntensity * ones( 1, size( mySpectra, 2)));
myRGBSimNorm = myRGBSim ./ (myIntensity * ones( 1, size( myRGBSim, 2)));

%%%%%%%%%%%%%%%%%%
% Farbreizschätzung
%%%%%%%%%%%%%%%%%%

% Kameraempfindlichkeiten mit dem Lichtspektrum kombinieren:
mySensitivitiesCamIllum = diag( myIllum) * mySensitivitiesCam;

% Spektralschätzung mit Pseudo-Inversen aus den simulierten RGB:
%mySpectralEstimate = estimateSpectraIE( mySensitivitiesCamIllum, myRGBSim, myCovMatrixSpec);
myPISpectral = mySensitivitiesCamIllum * inv( mySensitivitiesCamIllum' * mySensitivitiesCamIllum);

%myRGBSim = myRGBOrig;
mySpectralEstimate = myRGBSimNorm * myPISpectral';

mySpectraMetamer = mySpectraNorm - mySpectralEstimate;

%PCA auf metamere Anteile
myNumberofComps = 10;
myOrder = 3;
myFStatic = 1;%Static coeffs

myBase = getPrincipalComponents( mySpectraMetamer, myNumberofComps);

myComponents = mySpectraNorm * myBase;

myKoeffMatrix = learnPCAFit( myComponents, myRGBSimNorm, myOrder, myFStatic);
myComponentsFit = applyPCAFit( myRGBSimNorm, myOrder, myKoeffMatrix, myFStatic);
mySpectraFitNorm = myRGBSimNorm * myPISpectral' + myComponentsFit * myBase';
mySpectraFit = mySpectraFitNorm .* (myIntensity * ones( 1, size( mySpectra, 2)));
%mySpectraFit( find( mySpectraFit < 0)) = 0;


%%%%%%%%%%%%%%%%%%
% Auswertung
%%%%%%%%%%%%%%%%%%

% myRGBFit = simRGBfromSpectra( mySpectraFit, myIllum, mySensitivitiesCam);
% plot1D3Compare( myRGBSim, myRGBFit, 'RGB Sim vs. RGB Fit');
% RGBEvaluation( myRGBSim, myRGBFit);

% Spektralabtastung der geschätzten Spektren mit den xyz-Empfindlichkeiten durchführen 
% und mit den originalen XYZ vergleichen:
myXYZOriginal = simXYZfromSpectra( mySpectra, myIllum);
myXYZFit = simXYZfromSpectra( mySpectraFit, myIllum);
plot1D3Compare( myXYZOriginal, myXYZFit, 'XYZ Fit Test');

% Vergleich verschiedener Spektren Original <-> Schätzung:
plot1DSpectralCompare( mySpectra( 27, :), mySpectraFit( 27, :), 'Patch 27');
plot1DSpectralCompare( mySpectra( 35, :), mySpectraFit( 35, :), 'Patch 35');
plot1DSpectralCompare( mySpectra( 43, :), mySpectraFit( 43, :), 'Patch 43');
plot1DSpectralCompare( mySpectra( 51, :), mySpectraFit( 51, :), 'Patch 51');
plot1DSpectralCompare( mySpectra( 59, :), mySpectraFit( 59, :), 'Patch 59');
plot1DSpectralCompare( mySpectra( 28, :), mySpectraFit( 28, :), 'Patch 28');
plot1DSpectralCompare( mySpectra( 29, :), mySpectraFit( 29, :), 'Patch 29');
plot1DSpectralCompare( mySpectra( 86, :), mySpectraFit( 86, :), 'Patch 86');

% grafische Auswertung
myOriginalLab = imXYZ2Lab( myXYZOriginal, myXYZOriginal( myWhitePatch, :));
myEstimateLab = imXYZ2Lab( myXYZFit, myXYZFit( myWhitePatch, :));
LabEvaluationIE( myEstimateLab, myOriginalLab);




% Test unbek. Spektren:
mySpectraUnknown = getInternalPatches( getSpectraIE( 'digColorCheckerSG_eye1_spektral.txt'));
% mySpectraUnknown = getSpectraIE( 'AllMinusKrinov');


% Spektralabtastung mit den gefundenen Empfindlichkeiten simulieren:
myRGBSimUnknown = simRGBfromSpectra( mySpectraUnknown, myIllum, mySensitivitiesCam);
myIntensityUnknown = myRGBSimUnknown( :, 1) + myRGBSimUnknown( :, 2) + myRGBSimUnknown( :, 3);
%mySpectraUnknownNorm = mySpectraUnknown ./ (myIntensityUnknown * ones( 1, size( mySpectraUnknown, 2)));
myRGBSimUnknownNorm = myRGBSimUnknown ./ (myIntensityUnknown * ones( 1, size( myRGBSimUnknown, 2)));

myComponentsUnknownFit = applyPCAFit( myRGBSimUnknownNorm, myOrder, myKoeffMatrix, myFStatic);
mySpectraUnknownFitNorm = myRGBSimUnknownNorm * myPISpectral' + myComponentsUnknownFit * myBase';
mySpectraUnknownFit = mySpectraUnknownFitNorm .* (myIntensityUnknown * ones( 1, size( mySpectraUnknown, 2)));

%%%%%%%%%%%%%%%%%%
% Auswertung
%%%%%%%%%%%%%%%%%%

% myRGBFitUnknown = simRGBfromSpectra( mySpectraUnknownFit, myIllum, mySensitivitiesCam);
% plot1D3Compare( myRGBSimUnknown, myRGBFitUnknown, 'RGB Sim vs. RGB Fit');
% RGBEvaluation( myRGBSimUnknown, myRGBFitUnknown);

% Spektralabtastung der geschätzten Spektren mit den xyz-Empfindlichkeiten durchführen 
% und mit den originalen XYZ vergleichen:
myXYZOriginalUnknown = simXYZfromSpectra( mySpectraUnknown, myIllum);
myXYZFitUnknown = simXYZfromSpectra( mySpectraUnknownFit, myIllum);
plot1D3Compare( myXYZOriginalUnknown, myXYZFitUnknown, 'XYZ Fit Test');

% grafische Auswertung
myOriginalLabUnknown = imXYZ2Lab( myXYZOriginalUnknown, myXYZOriginal( myWhitePatch, :));
myEstimateLabUnknown = imXYZ2Lab( myXYZFitUnknown, myXYZFit( myWhitePatch, :));
LabEvaluationIE( myEstimateLabUnknown, myOriginalLabUnknown);


