function theFlareInfo = computeFlareCorrection( theRGBSimGrey, theCameraGrey, theRGBMax)
%myLutAccuracy = 16; %16 bit Genauigkeit

%Bereich Kamera Werte
myMin = 0; %min( theCameraGrey( :, :));
myMax = theRGBMax;
% kFlareLUTMin = 0;
% kFlareLUTMax = max( theRGBSimGrey);

%Eintragen aller Werte von Dvis min bis Dvis max; dazwischen 16 bit Werte interpolieren:
myCamGrid = myMin : myMax; 
%myCamGrid = myMin: (myMax-myMin)/(2^myLutAccuracy-1): myMax; 

% Kanäle:
for i=1:3
	
% 	%Linearer Fit 
% 	p = polyfit( theCameraGrey( :, i), theRGBSimGrey( :, i), 1);	%linearer Fit
% 	myCamCorrData = polyval( p, myCamGrid(:));
	
	%Fit mit Gewichten
	myPolyOrder = 1;	%Linearer Fit
	myWeights = theRGBSimGrey( :, i) .^(-0.5);
%	myWeights = ones( size( theRGBSimGrey, 1), 1, 'double');
	
	myKoeff = learnFit( theRGBSimGrey( :, i), theCameraGrey( :, i), myPolyOrder, 'Static', myWeights);

	myOffset( i) = myKoeff( 1);
	%ToDo: 
	myKoeff( 2) = 1;
	mySlope( i) = myKoeff( 2);
	
	myCamCorrData = applyFit( myCamGrid(:), 1, myKoeff, 'Static');
% 	myCamCorrData = interp1( theCameraGrey( :, i), theRGBSimGrey( :, i), myCamGrid, 'cubic');
	myFlareLuts( :, i) = uint16( min( myMax, max( 0, max( myMin, round( myCamCorrData( :))))));
end

theFlareInfo.Offset =  myOffset;
theFlareInfo.Slope =  mySlope;
theFlareInfo.FlareLuts = myFlareLuts;


plot1D3Soll_Ist( myFlareLuts, myCamGrid, 'FlareLuts');
%plot1D3Soll_Ist( theFlareLuts*(2^myLutAccuracy-1)/theRGBMax, (1:(2^myLutAccuracy)), 'FlareLuts');

%save FlareLut.mat theFlareInfo;

