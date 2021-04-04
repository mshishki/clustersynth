function [theFlareLuts, theFlareInfo] = computeFlareLuts( theRGBSimGrey, theCameraGrey, theRGBMax)
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
	p = polyfit( theCameraGrey( :, i), theRGBSimGrey( :, i), 1);	%linearer Fit
	myCamCorrData = polyval( p, myCamGrid);
	
	myOffset( i) = p( 2);
	mySlope( i) = p( 1);
	
% 	myCamCorrData = interp1( theCameraGrey( :, i), theRGBSimGrey( :, i), myCamGrid, 'cubic');
	theFlareLuts( :, i) = uint16( min( myMax, max( 0, max( myMin, round( myCamCorrData( :))))));
end

theFlareInfo.Offset =  myOffset;
theFlareInfo.Slope =  mySlope;


plot1D3Soll_Ist( theFlareLuts, myCamGrid, 'FlareLuts');
%plot1D3Soll_Ist( theFlareLuts*(2^myLutAccuracy-1)/theRGBMax, (1:(2^myLutAccuracy)), 'FlareLuts');

save FlareLut.mat theFlareLuts;

end %computeFlareLuts

