function theDoubleImage = getRawDoubleImage( theImage, theMaxVal, theOffset)

theDoubleImage = (double( theImage)-theOffset) / ...
						(theMaxVal-theOffset); 