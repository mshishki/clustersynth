function plot1D3( theCurves, theXGrid, theColor, theWinTitle)
%Usage: plot1D3( theCurves, theXGrid, theColor, theWinTitle);
%Optional: theWinTitle

if( nargin == 1)
	theXGrid = 1:length( theCurves);
	theColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
	theWinTitle = inputname( 1);
end

if( nargin == 2)
	theColor = ['r', 'g', 'b', 'c', 'm', 'y', 'k'];
	theWinTitle = inputname( 1);
end

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end
hold on;
if( iscell( theColor))
	for i=1:size( theCurves, 2)
		plot( theXGrid, theCurves( :, i), theColor{ i}, 'LineWidth', 2);
	end
else
	for i=1:size( theCurves, 2)
		plot( theXGrid, theCurves( :, i), theColor( i), 'LineWidth', 2);
	end
end
hold off;
