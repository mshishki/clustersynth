function theBase = getPrincipalComponents( theSpectra, theNumComponents)

[ myBase, myNewCoordinates, myEigenvalues] = princomp( theSpectra);
theBase = myBase( :, 1:theNumComponents);

figure();
plot( myNewCoordinates( :, 1), myNewCoordinates( :, 2), '+')
xlabel( '1st Principal Component');
ylabel( '2nd Principal Component');

figure();
plot( myNewCoordinates( :, 1), myNewCoordinates( :, 3), '+')
xlabel( '1st Principal Component');
ylabel( '3rd Principal Component');


% plot1D3Spectral( theBase( :, 1:3), 'Principal Components 1:3');
% plot1D3Spectral( theBase( :, 4:6), 'Principal Components 4:6');
% plot1D3Spectral( theBase( :, 7:9), 'Principal Components 7:9');
% plot1D3Spectral( theBase( :, 10:12), 'Principal Components 10:12');
% plot1D3Spectral( theBase( :, 13:15), 'Principal Components 13:15');
% plot1D3Spectral( theBase( :, 16:18), 'Principal Components 16:18');

disp(  'Eigenwerte: ');
disp(  num2str( myEigenvalues( 1:theNumComponents)));
