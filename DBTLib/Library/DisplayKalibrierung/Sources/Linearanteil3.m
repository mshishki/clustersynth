function [theTestSpectrum, theXYZTest, theRGBXYZINV, theLinear, myXYZCurves] = Linearanteil3( theRGBData, theSpectralData, theXYZ_BP, theRGB2XYZMatrix )

theTestIndex = find( theRGBData( :, 1) == 255 & theRGBData( :, 2) == 255 & theRGBData( :, 3) == 255);
theTestSpectrum = theSpectralData( theTestIndex, :);


myXYZCurves = getXYZCurves_10nm();

theXYZTest = theTestSpectrum * myXYZCurves;

theRGBXYZINV = inv(theRGB2XYZMatrix);

theLinear = theRGBXYZINV * theXYZTest';