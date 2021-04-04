function theGraySpectraIdeal = makeGrayIdeal( theGraySpectraReal)

[myNumSpectra, myNumWavel] = size( theGraySpectraReal);

for( i=1:myNumSpectra)
	myRem = mean( theGraySpectraReal( i, :));
	theGraySpectraIdeal( i, :) = ones( 1, myNumWavel) * myRem;
end