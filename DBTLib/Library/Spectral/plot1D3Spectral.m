function plot1D3Spectral( theCurves, theWinTitle)
%Usage: plot1D3Spectral( theCurves, theWinTitle);
%Optional: theWinTitle
%theCurves: 3 column vectors [36x3]

if exist( 'theWinTitle')==0
    plot1D3( theCurves, 380:10:730, [ 'r', 'g', 'b']);
else
    plot1D3( theCurves, 380:10:730, [ 'r', 'g', 'b'], theWinTitle);
end
