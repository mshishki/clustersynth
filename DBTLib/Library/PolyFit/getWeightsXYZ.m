function theWeightVector_n_x_N = getWeightsXYZ( theXYZ, theXYZWhitePoint)

myDelta = max( max( theXYZ)) / 1000;

myLabOriginal = imXYZ2Lab( theXYZ, theXYZWhitePoint);

myDeltaX = theXYZ;
myDeltaX( :, 1) = myDelta; 
myDeltaX( :, 2) = 0; 
myDeltaX( :, 3) = 0;
myLabDeltaX = imXYZ2Lab( theXYZ+myDeltaX, theXYZWhitePoint);
myDeltaEX = getDeltaE( myLabOriginal, myLabDeltaX);

myDeltaY = theXYZ;
myDeltaY( :, 1) = 0; 
myDeltaY( :, 2) = myDelta; 
myDeltaY( :, 3) = 0;
myLabDeltaY = imXYZ2Lab( theXYZ+myDeltaY, theXYZWhitePoint);
myDeltaEY = getDeltaE( myLabOriginal, myLabDeltaY);

myDeltaZ = theXYZ;
myDeltaZ( :, 1) = 0; 
myDeltaZ( :, 2) = 0; 
myDeltaZ( :, 3) = myDelta;
myLabDeltaZ = imXYZ2Lab( theXYZ+myDeltaZ, theXYZWhitePoint);
myDeltaEZ = getDeltaE( myLabOriginal, myLabDeltaZ);

theWeightVector_n_x_N = [myDeltaEX, myDeltaEY, myDeltaEZ];


