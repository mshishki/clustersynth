function plot1DSpectral( theCurve, theWinTitle)
%Usage: plot1DSpectral( theCurve, theWinTitle);
%Optional: theWinTitle

if exist( 'theWinTitle')==0
    plot1D( theCurve, 380:10:730, ['b']);
else
    plot1D( theCurve, 380:10:730, ['b'], theWinTitle);
end
