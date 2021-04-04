function DrawSpectralCurve( theChromaticityChartFigure, theAxisFactor)
if ~exist( 'theAxisFactor')
	theAxisFactor = 1;
end
myXYZCurves = getXYZCurves_10nm();
mySpectra = eye( 36);

if( exist( 'theChromaticityChartFigure') && ~isempty( theChromaticityChartFigure))
	figure( theChromaticityChartFigure);
else
	figure();
	axis([ 0,  1, 0, 1]);% x - y
	xlabel('x'); ylabel ('y');
end

myXYZ_SpectralCurve = mySpectra * myXYZCurves;
my_xy = XYZ2xy( myXYZ_SpectralCurve) * theAxisFactor;
my_x_fine = interp1( 1:36, my_xy( :, 1), 1:0.1:36, 'spline');
my_y_fine = interp1( 1:36, my_xy( :, 2), 1:0.1:36, 'spline');

hold on

plot( my_x_fine( :), my_y_fine( :), 'r', 'LineWidth', 2);
plot( [ my_xy( 1, 1); my_xy( end, 1)], [ my_xy( 1, 2); my_xy( end, 2)], 'r', 'LineWidth', 2);

hold off
