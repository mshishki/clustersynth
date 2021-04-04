function [theRGB, theSpectralFlux] = simRGBfromSpectraWB( theSpectralData, theIllumination, theRGBCurves, theWhitePatchNr)
%Usage: [theRGB, theSpectralFlux] = simRGBfromSpectra( theSpectralData,
%                                           theIllumination, theRGBCurves);
%Optional: theSpectralFlux

[myRGB, mySpectralFlux] = simRGBfromSpectra( theSpectralData, theIllumination, theRGBCurves);

%RGB White ermitteln
if( exist( 'theWhitePatchNr', 'var') && ~isempty( theWhitePatchNr))
	myRGBWhite = myRGB( theWhitePatchNr, :);
else
	myRGBWhite = simRGBfromSpectra( getWhiteSpectrum( theSpectralData), theIllumination, theRGBCurves);
end

%Weiﬂabgleich
myRGBNorm = myRGB; 
myRGBNorm( :, 1) = myRGB( :, 1) ./ myRGBWhite( 1);
myRGBNorm( :, 2) = myRGB( :, 2) ./ myRGBWhite( 2);
myRGBNorm( :, 3) = myRGB( :, 3) ./ myRGBWhite( 3);

theRGB = myRGBNorm;

if( nargout == 2)
    theSpectralFlux = mySpectralFlux;
end
