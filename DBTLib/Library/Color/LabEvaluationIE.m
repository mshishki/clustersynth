function theDeltaE = LabEvaluationIE( theLabIst, theLabSoll, theAdditiveTitle, theFGraphOnOff)
%Usage: theDeltaE = LabEvaluationIE( theLabIst, theLabSoll);

if exist( 'theAdditiveTitle', 'var') && ~isempty( theAdditiveTitle)
	myAdditiveTitle = theAdditiveTitle;	
else
	myAdditiveTitle = '';	%default 
end

if exist( 'theFGraphOnOff', 'var') && ~isempty( theFGraphOnOff)
	myDeltaEOn = theFGraphOnOff.DeltaEHistogram;	
	myLabDiffOn = theFGraphOnOff.LabDiff;	
	myColorChartOn = theFGraphOnOff.ColorChart;	
else %default
	myDeltaEOn = 1;
	myLabDiffOn = 1;
	myColorChartOn = 1;
end

% grafische Auswertung Delta E
myDiff = theLabIst - theLabSoll;
 
[zeilen, spalten] = size( myDiff);
myDeltaE = zeros( zeilen, 1, 'double');
 
for i=1:zeilen
     myDeltaE( i, 1) = norm( myDiff( i, :));
end
 
if( ~strcmp( myAdditiveTitle, ''))
	disp( [ myAdditiveTitle, ':']);
end
disp( sprintf( 'Max. Delta E: %d', max( myDeltaE)));
disp( sprintf( 'Mean Delta E: %d', mean( myDeltaE)));
 
find ( myDeltaE == max( myDeltaE));
 
myHistogram = hist( myDeltaE( :, 1), 0:20);

if( myDeltaEOn)
	figure( 'Name', [ myAdditiveTitle, ' Delta E Histogram'], 'NumberTitle', 'off');
	plot( myHistogram / sum( myHistogram), 'LineWidth', 2);
	hold on;
	axis ([0 25 0 0.35]);
	hold off;
end

% grafische Auswertung aller a-b Diferenzen
myI1LabData = theLabSoll;
myImageLabData = theLabIst;
myRange = [-100, 100, -100, 100];
if( myLabDiffOn)
	showLabDifferenceDiagram( myI1LabData, myImageLabData, myRange, myAdditiveTitle);
end

myI1LabPatchImage = formatImage( myI1LabData);
myCamLabPatchImage = formatImage( myImageLabData);

if( myColorChartOn)
	showLabDiffImages( myI1LabPatchImage, myCamLabPatchImage, 20, 10, myAdditiveTitle);
end

theDeltaE = myDeltaE;