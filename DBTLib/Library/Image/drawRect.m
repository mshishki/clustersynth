function theImagePlusRect = drawRect( theImage, theRect)

theImagePlusRect = theImage;
myRect = round( theRect);

XLeft = myRect( 1);
YTop = myRect( 2);
XRight = XLeft + myRect( 3)-1;
YBottom = YTop + myRect( 4)-1;

switch( class( theImage))
	case 'uint8'
		myMax = 255;
	case 'uint16'
		myMax = 2^16-1;
	otherwise
		myMax = 1;
end

if size( theImage, 3) == 1
	myColor = myMax;
else
	myColor = [0, myMax, 0];
end

for( color = 1:size( theImage, 3))
	theImagePlusRect( YTop, XLeft:XRight, color) = myColor( color);
	theImagePlusRect( YBottom, XLeft:XRight, color) = myColor( color);
	theImagePlusRect( YTop:YBottom, XLeft, color) = myColor( color);
	theImagePlusRect(  YTop:YBottom, XRight, color) = myColor( color);
end
