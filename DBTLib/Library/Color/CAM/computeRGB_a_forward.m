function theRGB_a = computeRGB_a_forward( theXYZ, theRGBParams)

myF_L = theRGBParams.F_L;
myD_RGB = theRGBParams.D_RGB;
myM_CAT02 = theRGBParams.M_CAT02;
myM_HPE = theRGBParams.M_HPE;
myM_HPE_CAT02 = myM_HPE * inv( myM_CAT02);

myRGB = myM_CAT02 * theXYZ;
myRGB_C( 1, :) = myRGB( 1, :) * myD_RGB( 1);
myRGB_C( 2, :) = myRGB( 2, :) * myD_RGB( 2);
myRGB_C( 3, :) = myRGB( 3, :) * myD_RGB( 3);

myRGB_ = myM_HPE_CAT02 * myRGB_C;

theRGB_a = real( 400*(((myF_L * myRGB_ / 100).^0.42) ./ ( ((myF_L * myRGB_ / 100).^0.42)+27.13)) + 0.1);
