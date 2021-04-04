function [theTestSpectrum, theXYZTest, theRGBXYZINV, theXYZClean, theLinear, myXYZCurves] = Linearanteil( theRGBData, theSpectralData, theXYZ_BP, theRGB2XYZMatrix )

theTestIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 255);
theTestSpectrum = theSpectralData( theTestIndex, :);


myXYZCurves = getXYZCurves_10nm();

theXYZTest = theTestSpectrum * myXYZCurves;

theXYZClean = theXYZTest - theXYZ_BP;

theRGBXYZINV = inv(theRGB2XYZMatrix);

theLinear = theRGBXYZINV * theXYZClean';



