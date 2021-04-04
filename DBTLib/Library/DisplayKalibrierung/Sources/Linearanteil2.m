function [theXYZTest, theRGBXYZINV, theLinear, myXYZCurves] = Linearanteil2(theSpectralData,theRGB2XYZMatrix, myYFactor )

myXYZCurves = getXYZCurves_10nm();

n = 99;

for i = 1:n,
theXYZTest(i, :) = theSpectralData( i, :) * myXYZCurves;

end

theXYZTest = theXYZTest * myYFactor;

theRGBXYZINV = inv(theRGB2XYZMatrix);

for i = 1:n
    
theLinear(i, :) = theRGBXYZINV * theXYZTest(i, :)';
end



