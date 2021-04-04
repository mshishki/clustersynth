function plot1D3( theCurves, theXGrid, theColor, theWinTitle)
%Usage: plot1D3( theCurves, theXGrid, theColor, theWinTitle);
%Optional: theWinTitle

if( nargin == 1)
	theXGrid = 1:length( theCurves);
	theColor = ['r', 'g', 'b'];
	theWinTitle = inputname( 1);
end

if( nargin == 2)
	theColor = ['r', 'g', 'b'];
	theWinTitle = inputname( 1);
end

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end
hold on;
if( iscell( theColor))
	plot( theXGrid, theCurves( :, 1), theColor{ 1}, 'LineWidth', 2);
	plot( theXGrid, theCurves( :, 2), theColor{ 2}, 'LineWidth', 2);
	plot( theXGrid, theCurves( :, 3), theColor{ 3}, 'LineWidth', 2);
else
	plot( theXGrid, theCurves( :, 1), theColor( 1), 'LineWidth', 2);
	plot( theXGrid, theCurves( :, 2), theColor( 2), 'LineWidth', 2);
	plot( theXGrid, theCurves( :, 3), theColor( 3), 'LineWidth', 2);
end
hold off;
