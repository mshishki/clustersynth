function plot1DSpectralCompare( theCurveOrig, theCurveEstim, theWinTitle)
%Usage: plot1DSpectralCompare( theCurveOrig, theCurveEstim, theWinTitle);
%Optional: theWinTitle

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end
hold on;

%plot( 380:10:730, theCurveOrig( :), 'b', 380:10:730, theCurveEstim( :), 'm');
plot( 380:10:730, theCurveOrig( :), 'b');
plot( 380:10:730, theCurveEstim( :), 'm');

h = legend('Original','Estimate',2);

hold off;
