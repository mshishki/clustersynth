function theDeltaE = LabEvaluationIE2( theLabIst, theLabSoll, theAdditiveTitle)
%Usage: theDeltaE = LabEvaluationIE( theLabIst, theLabSoll);

if exist( 'theAdditiveTitle', 'var') && ~isempty( theAdditiveTitle)
	myAdditiveTitle = theAdditiveTitle;	
else
	myAdditiveTitle = '';	%default 
end

% grafische Auswertung Delta E
myDiff = theLabIst - theLabSoll;
 
[zeilen, spalten] = size( myDiff);
myDeltaE = zeros( zeilen, 1, 'double');
 
for i=1:zeilen
     myDeltaE( i, 1) = norm( myDiff( i, :));
end
 
disp( [ myAdditiveTitle, ':']);
disp( sprintf( 'Max. Delta E: %d', max( myDeltaE)));
disp( sprintf( 'Mean Delta E: %d', mean( myDeltaE)));
 
find ( myDeltaE == max( myDeltaE));
 
myHistogram = hist( myDeltaE( :, 1), 0:20);

figure( 'Name', [ myAdditiveTitle, ' Delta E Histogram'], 'NumberTitle', 'off');
plot( myHistogram / sum( myHistogram));
hold on;
axis ([0 25 0 0.7]);
hold off;


% grafische Auswertung aller a-b Diferenzen
%myI1LabData = theLabSoll;
%myImageLabData = theLabIst;
%myRange = [-100, 100, -100, 100];
%showLabDifferenceDiagram( myI1LabData, myImageLabData, myRange, myAdditiveTitle);

%myI1LabPatchImage = formatImage( myI1LabData);
%myCamLabPatchImage = formatImage( myImageLabData);

%showLabDiffImages( myI1LabPatchImage, myCamLabPatchImage, 20, 10, myAdditiveTitle);

theDeltaE = myDeltaE;