function [ theLutR, theLutG, theLutB] = analyzeGamma( theRGBData, theRGBLin)
uint8max = 2^8-1;
uint16max = 2^16-1;

%Linearisierung:
myGamma = 2.2;

[myGreyRGB, myGreyRGBLin] = analyzeGrey( theRGBData, theRGBLin);

disp( 'Model Adjustment:');
disp( [ '( ', num2str( myGreyRGBLin( end, 1)), ', ', num2str( myGreyRGBLin( end, 2)), ', ', ...
	num2str( myGreyRGBLin( end, 3)), ')', ' -> (1, 1, 1)']);
disp( [ '( ', num2str( myGreyRGBLin( 1, 1)), ', ', num2str( myGreyRGBLin( 1, 2)), ', ', ...
	num2str( myGreyRGBLin( 1, 3)), ')', ' -> (0, 0, 0)']);

myGreyRGBLin( end, :) = 1.0;%Endpunkt geeignet setzen
myGreyRGBLin( 1, :) = 0.0;%Anfangspunkt geeignet setzen

%zwischen 0 und 1 begrenzen
theLutR = min( 1.0, max( interp1( myGreyRGB/uint8max, myGreyRGBLin( :, 1).^(1/myGamma), (0:1/uint16max:1)', 'spline'), 0)).^myGamma;
theLutG = min( 1.0, max( interp1( myGreyRGB/uint8max, myGreyRGBLin( :, 2).^(1/myGamma), (0:1/uint16max:1)', 'spline'), 0)).^myGamma;
theLutB = min( 1.0, max( interp1( myGreyRGB/uint8max, myGreyRGBLin( :, 3).^(1/myGamma), (0:1/uint16max:1)', 'spline'), 0)).^myGamma;
 