function showLabDifferenceDiagram( theLabSoll, theLabIst, theRange, theAdditiveTitle)

myNumLab = size( theLabSoll, 1);

myRange_aMin = theRange( 1);
myRange_aMax = theRange( 2);
myRange_bMin = theRange( 3);
myRange_bMax = theRange( 4);

C = makecform('lab2srgb');
myLDraw = 60;

my_ab_Figure = figure('Name',[ theAdditiveTitle, ' Color Differences a-b'], 'NumberTitle', 'off');
axes('NextPlot','add');
axis([ myRange_aMin,  myRange_aMax, myRange_bMin, myRange_bMax]);
xlabel('a'); ylabel ('b');
hold on

for k=1:myNumLab
	myLabcolor = [ myLDraw, theLabSoll( k, 2), theLabSoll( k, 3)];
	mycolor = applycform( myLabcolor,C);
	plot( theLabSoll( k, 2), theLabSoll( k, 3),'.','MarkerSize',12,'MarkerEdgeColor', mycolor);
	drawLine( [ theLabSoll( k, 2), theLabSoll( k, 3), theLabIst( k, 2), theLabIst( k, 3)],  mycolor);
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

line( x, y, 'Color', theColor, 'LineWidth', 1.0);
end
