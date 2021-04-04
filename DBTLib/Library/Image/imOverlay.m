function OutImage = overlayMask( InImage, Mask, Color)
			
myNumChan = size( InImage, 3);

for( i=1:myNumChan)
	if( i <= length( theValue))
		myVal = Color( i);
	else
		myVal = Color;
	end
	
	myChannel = InImage( :, :, i);
	myChannel( Mask) = myChannel( Mask) + myVal;
	OutImage( :, :, i) = myChannel;
end
