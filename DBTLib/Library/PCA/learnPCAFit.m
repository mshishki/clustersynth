function theKoeffMatrix = learnPCAFit( theComp, theRGB, theOrder, theFStatic)
%Usage:	theKoeffMatrix = learnPCAFit( theXYZ, theRGB, theOrder, theFStatic);
%Optional: theFStatic

%Polynom-Basisfunktionen holen:
if( exist( 'theFStatic')==1 && theFStatic==1) 
    myPolynomMatrix = getPolynomMatrixStatic( theRGB, theOrder);
else
    myPolynomMatrix = getPolynomMatrix( theRGB, theOrder);
end

%Fit und Datenübgergabe:
theKoeffMatrix = myPolynomMatrix\theComp;

