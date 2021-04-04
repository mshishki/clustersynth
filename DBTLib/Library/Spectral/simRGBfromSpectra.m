function [theRGB, theSpectralFlux] = simRGBfromSpectra( theSpectralData, theIllumination, theRGBCurves)
%Usage: [theRGB, theSpectralFlux] = simRGBfromSpectra( theSpectralData,
%                                           theIllumination, theRGBCurves);
%Optional: theSpectralFlux

mySpectralFlux = getSpectralFluxfromSpectra( theSpectralData, theIllumination);

theRGB = (mySpectralFlux * theRGBCurves);

if( nargout == 2)
    theSpectralFlux = mySpectralFlux;
end
