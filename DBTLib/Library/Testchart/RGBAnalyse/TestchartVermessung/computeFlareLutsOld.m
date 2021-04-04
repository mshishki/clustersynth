function theFlareLuts = computeFlareLuts( theYGrey, theCameraGrey)
myLutAccuracy = 16; %16 bit Genauigkeit

%Bereich Kamera Werte
myMin = 0; %min( theCameraGrey( :, :));
myMax = max( max( theCameraGrey));
kFlareLUTMin = 0;
kFlareLUTMax = max( theYGrey);

% Kanäle:
for i=1:3
	%Eintragen aller Werte von Dvis min bis Dvis max; dazwischen 16 bit Werte interpolieren:
	myCamGrid = myMin: (myMax-myMin)/(2^myLutAccuracy-1): myMax; 

	myCamCorrData = interp1( theCameraGrey( :, i), theYGrey, myCamGrid, 'cubic');
	theFlareLuts( :, i) = min( kFlareLUTMax, max( 0, max( kFlareLUTMin, myCamCorrData( :))));
end

plot1D3Soll_Ist( theFlareLuts, (1:(2^myLutAccuracy)), 'FlareLuts');

save FlareLut.mat theFlareLuts;

end %computeFlareLuts

