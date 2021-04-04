function [theXYZRGB_Out, theXYZCorr] = applyDisplayModel( theDisplayModel, theXYZRGB_In, theMode)
RGBMax = 1;%255;
uint16Max = 2^16-1;

switch theMode
	case 'backward'
		myXYZ = theXYZRGB_In;
		%Display-Modell rückwärts anwenden
		myXYZMinusBlack = myXYZ - ones( size( myXYZ, 1), 1) * theDisplayModel.Backward.BlackPoint;
		myRGBLin = myXYZMinusBlack * theDisplayModel.Backward.XYZ2RGBMatrix';
		
		%Normierung, damit keine Übersteuerung in RGBLin
		myRGBMax = max( myRGBLin);
		myNormFaktor = max( max( myRGBMax(:)), 1);
		myXYZNorm = myXYZ / myNormFaktor;%Stimmt hier wegen dem Blackpoint nicht so ganz, aber fast :-)

		myXYZMinusBlack = myXYZNorm - ones( size( myXYZ, 1), 1) * theDisplayModel.Backward.BlackPoint;
		myRGBLin = min( max( myXYZMinusBlack * theDisplayModel.Backward.XYZ2RGBMatrix', 0), 1);

		myRDisp = theDisplayModel.Backward.Lut.R( round( myRGBLin( :, 1)*uint16Max) +1);
		myGDisp = theDisplayModel.Backward.Lut.G( round( myRGBLin( :, 2)*uint16Max) +1);
		myBDisp = theDisplayModel.Backward.Lut.B( round( myRGBLin( :, 3)*uint16Max) +1);
		myRGBDisp = [ myRDisp(:), myGDisp(:), myBDisp(:)] * RGBMax;
		
		theXYZRGB_Out = myRGBDisp;
		%theXYZRGB_Out = round( myRGBDisp);
		theXYZCorr = myXYZNorm;
		
	otherwise
		%'forward'
		myRGBDisp = theXYZRGB_In;
		%Display-Modell vorwärts anwenden
		myRLin = theDisplayModel.Forward.Lut.R( round( myRGBDisp(:, 1)/RGBMax*uint16Max) + 1);
		myGLin = theDisplayModel.Forward.Lut.G( round( myRGBDisp(:, 2)/RGBMax*uint16Max) + 1);
		myBLin = theDisplayModel.Forward.Lut.B( round( myRGBDisp(:, 3)/RGBMax*uint16Max) + 1);
		myRGBLin = [ myRLin(:), myGLin(:), myBLin(:)];
		
		myXYZMinusBlack = myRGBLin * theDisplayModel.Forward.RGB2XYZMatrix';
		myXYZ = myXYZMinusBlack + ones( size( myXYZMinusBlack, 1), 1) * theDisplayModel.Forward.BlackPoint;
		
		theXYZRGB_Out = myXYZ;
		theXYZCorr = [];
end

