function theCovarianceMatrix = getMarkovCovarianceMatrix( theDim, theRoh)

myCovSpecMatrix = ones( theDim, theDim);
for i=1:theDim
	for j=1:theDim
		myCovSpecMatrix( i, j) = theRoh^( abs( i-j));
	end
end

theCovarianceMatrix = myCovSpecMatrix;
end %function getMarkovCovarianceMatrix
