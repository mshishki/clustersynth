function plotRect( theRect, theColor)

myRect = round( theRect);

XLeft = myRect( 1);
YTop = myRect( 2);
XRight = XLeft + myRect( 3)-1;
YBottom = YTop + myRect( 4)-1;


if exist( 'theColor')
	myColor = theColor;
else
	myColor = 'w';
end

myX = [ XLeft, XRight, XRight, XLeft, XLeft];
myY = [ YTop, YTop, YBottom, YBottom, YTop];

line( myX, myY, 'Color', myColor, 'LineWidth', 1);
