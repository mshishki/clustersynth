function theRGBTrafoMatrix = getTrafoMatrixFromLinProfiles( theProfileLinRGBIn, theProfileLinRGBOut)

theRGBTrafoMatrix = imColorTransform( diag( [1,1,1]), theProfileLinRGBIn, ...
									theProfileLinRGBOut)';
