function theComponentsFit = applyPCAFit(  theRGB, theOrder, theKoeffMatrix, theFStatic)
%Usage:		theComponentsFit = applyFit(  theRGB, theOrder, theKoeffMatrix, theFStatic);
%Optional: theFStatic

%Fit anwenden:
if( exist( 'theFStatic')==1 && theFStatic==1) 
    myPolynomMatrix = getPolynomMatrixStatic( theRGB, theOrder);
else
    myPolynomMatrix = getPolynomMatrix( theRGB, theOrder);
end

theComponentsFit = myPolynomMatrix * theKoeffMatrix;

