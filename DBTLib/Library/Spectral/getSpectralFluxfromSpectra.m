function theSpectralFlux = getSpectralFluxfromSpectra( theSpectralData, theIllumination)
%Usage: theSpectralFlux = getSpectralFluxfromSpectra( theSpectralData,
%                                                       theIllumination);

myNumSpectra = size( theSpectralData, 1);

for i=1:myNumSpectra
	mySpectralFlux( i, :) = theSpectralData( i, :) .* theIllumination';
end

theSpectralFlux = mySpectralFlux;