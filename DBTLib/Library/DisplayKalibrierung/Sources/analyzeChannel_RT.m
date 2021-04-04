function [theScaleRGB, theScaleSpectra, theScaleIndices] = analyzeChannel( theRGBData, theSpectralData, theChannel)

switch theChannel
	case 1
		c1 = 2;
		c2 = 3;
		color = 'r';
	case 2
		c1 = 1;
		c2 = 3;
		color = 'g';
	case 3
		c1 = 1;
		c2 = 2;
		color = 'b';
	otherwise
end

%Spektren
myScaleIndices = find( theRGBData( :, c1)==0 & theRGBData( :, c2)==0);
[ myScale, myScaleIndSorted] = sort( theRGBData( myScaleIndices, theChannel));
myScaleSpectra  = theSpectralData( myScaleIndices( myScaleIndSorted), :);
figure();
hold on;
for i=1:numel( myScaleIndSorted)
	plot( 380:10:730, myScaleSpectra( i, :), color,'LineWidth', 1.5);
end
hold off;

figure();
hold on;
for i=1:numel( myScaleIndSorted)
	plot( 380:10:730, myScaleSpectra( i, :)/norm( myScaleSpectra( i, :)), color, 'LineWidth', 1.5);
end
hold off;

%Linearität
figure();
plot( theRGBData( myScaleIndices( myScaleIndSorted), theChannel), ...
		sum( myScaleSpectra, 2), [ '-+', color], 'LineWidth', 1.5);
	
if nargout > 0
	theScaleRGB = theRGBData( myScaleIndices( myScaleIndSorted), theChannel);
end
if nargout > 1
	theScaleSpectra = myScaleSpectra;
end
if nargout > 2
	theScaleIndices = myScaleIndices( myScaleIndSorted);
end