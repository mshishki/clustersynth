function fHasFigure = hasFigure( theFigureHandleArray)
fHasFigure = 0;
if ~isempty( theFigureHandleArray)
	myZeroArray = theFigureHandleArray; 
	myZeroArray( :) = 0;
	if ~isequal( theFigureHandleArray, myZeroArray)
		fHasFigure = 1;
	end
end

