function plot1D( theCurve, theXGrid, theColor, theWinTitle)
%Usage: plot1D( theCurve, theXGrid, theColor, theWinTitle);
%Optional: theWinTitle

if( nargin == 1)
	theXGrid = 1:length( theCurve);
	theColor = 'b';
	theWinTitle = inputname( 1);
end

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end

plot( theXGrid, theCurve( :), theColor( 1), 'LineWidth', 2);

set(gcf, 'color', 'white');
% fig = gcf;
% style = hgexport('factorystyle');
% style.Bounds = 'tight';
% hgexport(fig,'-clipboard',style,'applystyle', true);
% drawnow;
