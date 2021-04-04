function plot1DCompare( theOut, theIn, theWinTitle)
%Usage: plot1D3Comparison( theRGBIst, theRGBSoll, theWinTitle);

myMaxValue = max( theIn(:));

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure( 'Name', 'RGB Comparison', 'NumberTitle', 'off');
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end

hold on;

plot( 0:myMaxValue*1.1, 0:myMaxValue*1.1, 'k');

plot( theIn( :), theOut( :), 'b+');
% if exist( 'theBinMask')==0 || isempty(theBinMask)==1
% 	plot( theIn( :), theOut( :), 'b+');
% else
% 	plot( theIn( theBinMask), theOut( theBinMask), 'b+');
% end
xlabel( 'Soll');
ylabel( 'Ist');

hold off;

