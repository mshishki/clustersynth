function theImageColored = drawColorMask( theImage, theRect, theRGBColor, theMask)

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
		YMask = j-YTop+1;
		XMask = i-XLeft+1;
		
		theImageColored( j, i, 1) = theImageColored( j, i, 1)*( theMask( YMask, XMask)==0)...
									+ theRGBColor( 1)*( theMask( YMask, XMask)==1);
		theImageColored( j, i, 2) = theImageColored( j, i, 2)*( theMask( YMask, XMask)==0)...
									+ theRGBColor( 2)*( theMask( YMask, XMask)==1);
		theImageColored( j, i, 3) = theImageColored( j, i, 3)*( theMask( YMask, XMask)==0)...
									+ theRGBColor( 3)*( theMask( YMask, XMask)==1);
	end
end
