function [theXYZ, theSpectralFlux] = simXYZfromSpectra( theSpectralData, theIllumination)
%Usage: [theXYZ, theSpectralFlux] = simXYZfromSpectra( theSpectralData, theIllumination);
%Optional: theSpectralFlux

myXYZCurves = getXYZCurves_10nm();

myNumSpectraProof = size( theSpectralData, 1);

Yw = theIllumination'*myXYZCurves( :, 2);
for i=1:myNumSpectraProof
	mySpectralFlux( i, :) = theSpectralData( i, :) .* theIllumination';
end
theXYZ = (mySpectralFlux * myXYZCurves)*100/Yw;

if( nargout == 2)
    theSpectralFlux = mySpectralFlux;
end
