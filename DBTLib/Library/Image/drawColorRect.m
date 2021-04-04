function theImageColored = drawColorRect( theImage, theRect, theRGBColor)

%Wird Farbbild mit 3 Kanälen
theImageColored = theImage;
if size( theImageColored, 3) == 1
	theImageColored( :, :, 2) = theImageColored( :, :, 1);
	theImageColored( :, :, 3) = theImageColored( :, :, 1);
end
	

myRect = round( theRect);

XLeft = myRect( 1);
YTop = myRect( 2);
XRight = XLeft + myRect( 3)-1;
YBottom = YTop + myRect( 4)-1;

for i=XLeft:XRight
	for j=YTop:YBottom
		theImageColored( j, i, 1) = ( theImageColored( j, i, 1) + theRGBColor( 1)) / 2;
		theImageColored( j, i, 2) = ( theImageColored( j, i, 2) + theRGBColor( 2)) / 2;
		theImageColored( j, i, 3) = ( theImageColored( j, i, 3) + theRGBColor( 3)) / 2;
	end
end
