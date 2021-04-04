function plot1D3Soll_Ist( theIstCurves, theSollCurves, theWinTitle)
%Usage: plot1D3Soll_Ist( theIstCurves, theSollCurves, theWinTitle);
%Optional: theWinTitle
%theSollCurves may be 1-dimensional

myMaxValue = max( max( theSollCurves));
myMinValue = min( min( theSollCurves));

if ~exist( 'theWinTitle') || isempty(theWinTitle)
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end

if (size( theSollCurves, 2) == 1) || (size( theSollCurves, 1) == 1)
	%Dimensionen erweitern:
	mySollCurves( :, 1) = theSollCurves( :);
	mySollCurves( :, 2) = theSollCurves( :);
	mySollCurves( :, 3) = theSollCurves( :);
else
	mySollCurves = theSollCurves;
end

hold on;

plot( 0:(myMaxValue*1.1),  0:(myMaxValue*1.1), '--k');

if( size( mySollCurves, 1) > 100)
	%zu viele Stützpunkte, um zu markieren
	plot( mySollCurves( :, 1), theIstCurves( :, 1), '-r');
	plot( mySollCurves( :, 2), theIstCurves( :, 2), '-g');
	plot( mySollCurves( :, 3), theIstCurves( :, 3), '-b');
else
	plot( mySollCurves( :, 1), theIstCurves( :, 1), '-r+');
	plot( mySollCurves( :, 2), theIstCurves( :, 2), '-g+');
	plot( mySollCurves( :, 3), theIstCurves( :, 3), '-b+');
end

xlabel( 'Soll');
ylabel( 'Ist');

hold off;

