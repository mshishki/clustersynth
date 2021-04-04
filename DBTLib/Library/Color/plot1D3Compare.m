function plot1D3Compare( theRGBIst, theRGBSoll, theWinTitle)
%Usage: plot1D3Comparison( theRGBIst, theRGBSoll, theWinTitle);

myMaxValue = max( max( theRGBSoll));

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure( 'Name', 'RGB Comparison', 'NumberTitle', 'off');
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end

hold on;

plot( 0:myMaxValue*1.1, 0:myMaxValue*1.1, 'k');

plot( theRGBSoll( :, 1), theRGBIst( :, 1), 'r+');
plot( theRGBSoll( :, 2), theRGBIst( :, 2), 'g*');
plot( theRGBSoll( :, 3), theRGBIst( :, 3), 'bs');

xlabel( 'Soll');
ylabel( 'Ist');

hold off;


