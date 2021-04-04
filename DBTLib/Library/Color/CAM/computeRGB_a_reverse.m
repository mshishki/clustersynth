function theXYZCAM = computeRGB_a_reverse( theRGB_a, theRGBParams)

F_L = theRGBParams.F_L;
D_RGB = theRGBParams.D_RGB;
M_CAT02 = theRGBParams.M_CAT02;
M_HPE = theRGBParams.M_HPE;

myM_HPE_CAT02Inv = inv( M_HPE * inv( M_CAT02));

myRGB_ = 100/F_L * (((27.13 * abs( theRGB_a - 0.1)) ./ (400 - abs( theRGB_a - 0.1)))).^(1/0.42);
myIndex = find( theRGB_a < 0.1);
myRGB_( myIndex) = -myRGB_( myIndex);

myRGB_C = myM_HPE_CAT02Inv * myRGB_;
myRGB( 1, :) = myRGB_C( 1, :) / D_RGB( 1);
myRGB( 2, :) = myRGB_C( 2, :) / D_RGB( 2);
myRGB( 3, :) = myRGB_C( 3, :) / D_RGB( 3);

theXYZCAM = inv( M_CAT02) * myRGB;
