function [f, theLabIst, theLabSoll, theDeltaE] = Validierung2( theLinear, theRGB2XYZMatrix, theXYZ_BP, theXYZTest, theXYZ_WP )

n = 99;

for i = 1:n,

    f(i, :) = theRGB2XYZMatrix * theLinear(i, :)' + theXYZ_BP';

end

theLabIst = imXYZ2Lab3( f, theXYZ_WP);


theLabSoll = imXYZ2Lab2( theXYZTest, theXYZ_WP);


%theDeltaE = getDeltaE2( theLabIst, theLabSoll);


theDeltaE = LabEvaluationIE( theLabIst, theLabSoll);