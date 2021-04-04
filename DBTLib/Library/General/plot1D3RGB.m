function plot1D3RGB( theCurves, theXGrid, theWinTitle)
%Usage: plot1D3RGB( theCurves, theXGrid, theWinTitle);
%Optional: theWinTitle

if ~exist( 'theWinTitle') || isempty( theWinTitle)
	theWinTitle = inputname( 1);
end

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end
hold on;
plot( theXGrid, theCurves( :, 1), '-r+');
if size( theCurves, 2) > 1
	plot( theXGrid, theCurves( :, 2), '-g+');
end
if size( theCurves, 2) > 2
	plot( theXGrid, theCurves( :, 3), '-b+');
end
hold off;
