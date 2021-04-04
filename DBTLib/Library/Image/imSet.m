function OutImage = imSet( InImage, theMask, theValue)

myNumChan = size( InImage, 3);

for( i=1:myNumChan)
	if( i <= length( theValue))
		myVal = theValue( i);
	else
		myVal = theValue;
	end
	
	myChannel = InImage( :, :, i);
	myChannel( theMask) = myVal;
	OutImage( :, :, i) = myChannel;
end
	
