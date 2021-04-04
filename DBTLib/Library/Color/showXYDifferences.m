function showXYDifferences( theXYZIst, theXYZSoll, theChromaticityDiagramHandle)

myNumLab = size( theXYZIst, 1);

C = makecform('xyz2srgb');

figure( theChromaticityDiagramHandle);
hold on;

for k=1:myNumLab
	myXYZcolor = theXYZSoll( k, :);
	mycolor = applycform( myXYZcolor/100,C);
	
	myXYSoll = XYZ2xy( theXYZSoll( k, :));
	myXYIst = XYZ2xy( theXYZIst( k, :));
	
	plot( myXYSoll( 1), myXYSoll( 2),'.','MarkerSize',12,'MarkerEdgeColor', mycolor);
	drawLine( [ myXYSoll( 1), myXYSoll( 2), myXYIst( 1), myXYIst( 2)],  'r');
end

% legend( 'Chromaticities', 'Location', 'NO');

hold off
end

function drawLine( thePoints, theColor)
x1 = thePoints( 1);
x2 = thePoints( 3);
y1 = thePoints( 2);
y2 = thePoints( 4);

x = [ x1; x2];
y = [ y1; y2];

line( x, y, 'Color', theColor);
end
