function theSpectralEstimate = ReconstructSpectrum( theSpectra, theNumSpectrum, theNumberOfComps, theBase)

myOriginalSpectrum = theSpectra( theNumSpectrum, :)';
myCompVector = (myOriginalSpectrum'*theBase)';
myCompVector( theNumberOfComps+1 : end) = 0;
mySpectrumReconstruction = theBase * myCompVector;
plot1DSpectralCompare( myOriginalSpectrum, mySpectrumReconstruction, ['Comparison Spectrum', num2str( theNumSpectrum)]);

theSpectralEstimate = mySpectrumReconstruction;