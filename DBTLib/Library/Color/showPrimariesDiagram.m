function theFigureHandle = showPrimariesDiagram( theRSpectrum, theGSpectrum, theBSpectrum, theAdditiveTitle, theFNewFigure)
myXYZCurves = getXYZCurves_10nm();

myXYZ_R = theRSpectrum(:)' * myXYZCurves;
my_xyR = XYZ2xy( myXYZ_R);

myXYZ_G = theGSpectrum(:)' * myXYZCurves;
my_xyG = XYZ2xy( myXYZ_G);

myXYZ_B = theBSpectrum(:)' * myXYZCurves;
my_xyB = XYZ2xy( myXYZ_B);

myXYZ_W = myXYZ_R + myXYZ_G + myXYZ_B;
my_xyW = XYZ2xy( myXYZ_W);

my_xyD65 = XYZ2xy( getD65()' * myXYZCurves);

if theFNewFigure
	theFigureHandle = figure('Name',[ theAdditiveTitle], 'NumberTitle', 'off');
	%axes('NextPlot','add');
	axis([ 0,  1, 0, 1]);% x - y
	xlabel('x'); ylabel ('y');
end
hold on

plot( my_xyR(1), my_xyR( 2), 'xr', 'LineWidth', 2);
plot( my_xyG(1), my_xyG( 2), 'xg', 'LineWidth', 2);
plot( my_xyB(1), my_xyB( 2), 'xb', 'LineWidth', 2);
plot( my_xyD65(1), my_xyD65( 2), 'ok', 'LineWidth', 2); %D65 als Kreis
plot( my_xyW(1), my_xyW( 2), 'xy', 'LineWidth', 2);%Realer WP in Gelb

drawLine( [my_xyR, my_xyG], 'k', 1);
drawLine( [my_xyR, my_xyB], 'k', 1);
drawLine( [my_xyB, my_xyG], 'k', 1);

hold off
end

function drawLine( thePoints, theColor, theLineWidth)
x1 = thePoints( 1);
x2 = thePoints( 3);
y1 = thePoints( 2);
y2 = thePoints( 4);

x = [ x1; x2];
y = [ y1; y2];

line( x, y, 'Color', theColor, 'LineWidth', theLineWidth);
end
