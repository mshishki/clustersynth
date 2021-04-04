function theXYZFit = applyFit(  theRGB, theOrder, theKoeffMatrix, theStaticMode)
%Usage:		theXYZFit = applyFit(  theRGB, theOrder, theKoeffMatrix, theStaticMode);

if exist( 'theStaticMode', 'var') && ~isempty( theStaticMode)
	myMode = theStaticMode;	
else
	myMode = 'noStatic';	%default no Offset
end
	
%Fit anwenden:
myPolynomMatrix = getPolynomMatrix( theRGB, theOrder, myMode);
theXYZFit = myPolynomMatrix * theKoeffMatrix;

