function theBayerImage = im2Bayer( theRGBImage, theMode)

myR = theRGBImage( :, :, 1);
myG = theRGBImage( :, :, 2);
myB = theRGBImage( :, :, 3);

theBayerImage = myG;

switch( theMode)
	case 'rggb'
		theBayerImage( 1:2:end, 1:2:end) = myR( 1:2:end, 1:2:end);		
		theBayerImage( 2:2:end, 2:2:end) = myB( 2:2:end, 2:2:end);
	case 'grbg'
		theBayerImage( 1:2:end, 2:2:end) = myR( 1:2:end, 2:2:end);		
		theBayerImage( 2:2:end, 1:2:end) = myB( 2:2:end, 1:2:end);
	case 'bggr'
		theBayerImage( 1:2:end, 1:2:end) = myB( 1:2:end, 1:2:end);		
		theBayerImage( 2:2:end, 2:2:end) = myR( 2:2:end, 2:2:end);
	case 'gbrg'
		theBayerImage( 1:2:end, 2:2:end) = myB( 1:2:end, 2:2:end);		
		theBayerImage( 2:2:end, 1:2:end) = myR( 2:2:end, 1:2:end);
	otherwise
end