function theImage = imdisplayColorList( theList_Nx3, theWindowTitle)
%Usage: imdisplayColorList( theList_Nx3, theWindowTitle);
%Optional: theWindowTitle

myLowResImage = formatImage( theList_Nx3);

if exist( 'theWindowTitle')==0 
    imdisplay( imresize( myLowResImage, 20, 'nearest'));
else
    imdisplay( imresize( myLowResImage, 20, 'nearest'), theWindowTitle);
end

if nargout > 0
	theImage = myLowResImage;
end


