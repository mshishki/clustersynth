function DrawRGBTriangle( theChromaticityChartFigure, theMatrix, theColor)

if( exist( 'theFShowNew') && theFShowNew == 1)
	theChromaticityChartFigure = figure();
	axis([ 0,  1, 0, 1]);% x - y
	xlabel('x'); ylabel ('y');
else
	theChromaticityChartFigure = gcf();
end

myXYZ = eye( 3) * theMatrix';
my_xy = XYZ2xy( myXYZ);
my_xy( end+1, :) = my_xy( 1, :);

hold on
plot( my_xy( :, 1), my_xy( :, 2), [ 'x-', theColor], 'LineWidth', 1);
hold off
