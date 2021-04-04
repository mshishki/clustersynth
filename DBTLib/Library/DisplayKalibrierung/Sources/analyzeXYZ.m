function [ theXYZ_Black, theXYZ_White, theXYZ_R0, theXYZ_G0, theXYZ_B0, theRGB2XYZMatrix] = analyzeXYZ( theBlack, theWhite, theR0Spec, theG0Spec, theB0Spec)

myXYZCurves = getXYZCurves_10nm();

myRawXYZ_White = theWhite * myXYZCurves;
myYNorm = myRawXYZ_White( 2);
myNormFactor = 100 / myYNorm;
theXYZ_Black = theBlack * myXYZCurves * myNormFactor;
theXYZ_White = myRawXYZ_White * myNormFactor;

theXYZ_R0 = theR0Spec * myXYZCurves * myNormFactor;
theXYZ_G0 = theG0Spec * myXYZCurves * myNormFactor;
theXYZ_B0 = theB0Spec * myXYZCurves * myNormFactor;

theRGB2XYZMatrix = [ theXYZ_R0', theXYZ_G0', theXYZ_B0'];
