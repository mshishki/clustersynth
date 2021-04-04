close all hidden;

%mySpectra = getSpectraIE( 'digColorCheckerSG_eye1_spektral.txt');
mySpectra = getSpectraIE( 'AllMinusKrinov');

%PCA
[myBase, myNewCoordinates, myEigenvalues] = princomp( mySpectra);

figure();
plot(myNewCoordinates(:,1),myNewCoordinates(:,2),'+')
xlabel('1st Principal Component');
ylabel('2nd Principal Component');

figure();
plot(myNewCoordinates(:,1),myNewCoordinates(:,3),'+')
xlabel('1st Principal Component');
ylabel('3rd Principal Component');


plot1D3Spectral( myBase( :, 1:3), 'Principal Components 1:3');
plot1D3Spectral( myBase( :, 4:6), 'Principal Components 4:6');
plot1D3Spectral( myBase( :, 7:9), 'Principal Components 7:9');
plot1D3Spectral( myBase( :, 10:12), 'Principal Components 10:12');
plot1D3Spectral( myBase( :, 13:15), 'Principal Components 13:15');
plot1D3Spectral( myBase( :, 16:18), 'Principal Components 16:18');

myEigenvalues

mySpectra = getSpectraIE( 'digColorCheckerSG_eye1_spektral.txt');
myNumberofComps = 10;
ReconstructSpectrum( mySpectra, 27, myNumberofComps, myBase);
ReconstructSpectrum( mySpectra, 35, myNumberofComps, myBase);
ReconstructSpectrum( mySpectra, 43, myNumberofComps, myBase);
ReconstructSpectrum( mySpectra, 51, myNumberofComps, myBase);
ReconstructSpectrum( mySpectra, 59, myNumberofComps, myBase);
ReconstructSpectrum( mySpectra, 67, myNumberofComps, myBase);


%PCA ohne Gleichanteil
% mySpectraMean = mean( mySpectra, 1);
% mySpectraDiff = mySpectra - ones( size( mySpectra, 1), 1)*mySpectraMean;
% 
% [myBase, myNewCoordinates, myEigenvalues] = princomp( mySpectraDiff);
% 
% figure();
% plot(myNewCoordinates(:,1),myNewCoordinates(:,2),'+')
% xlabel('1st Principal Component');
% ylabel('2nd Principal Component');
% 
% 
% plot1D3Spectral( myBase( :, 1:3), 'Principal Components 1:3');
% plot1D3Spectral( myBase( :, 4:6), 'Principal Components 4:6');
% plot1D3Spectral( myBase( :, 7:9), 'Principal Components 7:9');
% plot1D3Spectral( myBase( :, 10:12), 'Principal Components 10:12');
% plot1D3Spectral( myBase( :, 13:15), 'Principal Components 13:15');
% plot1D3Spectral( myBase( :, 16:18), 'Principal Components 16:18');
