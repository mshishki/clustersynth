function theChromaticityChartFigure = showPrimaries( theSpectra, theColor, theFShowNew)

myXYZCurves = getXYZCurves_10nm();

if( exist( 'theFShowNew') && theFShowNew == 1)
	theChromaticityChartFigure = getChromaticitiesDiagram( 'Primaries Diagram');
else
	theChromaticityChartFigure = gcf();
end

myXYZ = theSpectra * myXYZCurves;
my_xy = XYZ2xy( myXYZ);

hold on
plot( my_xy( :, 1), my_xy( :, 2), [ 'x-', theColor], 'LineWidth', 1);
hold off
