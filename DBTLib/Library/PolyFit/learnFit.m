function theKoeffMatrix = learnFit( theAimVals, theSourceVals, theOrder, theStaticMode, theWeights)
%Usage:	theKoeffMatrix = learnFit( theAimVals, theSourceVals, theOrder, theStaticMode, theWeights);
%theStaticMode: 'Static' or 'noStatic'
%Static: with Offset; noStatic: no Offset

if exist( 'theStaticMode', 'var') && ~isempty( theStaticMode)
	myMode = theStaticMode;	
else
	myMode = 'noStatic';	%default no Offset
end

%Polynom-Basisfunktionen holen:
myPolynomMatrix = getPolynomMatrix( theSourceVals, theOrder, myMode);
%Hinweis, daß kein Offset vorgesehen wird (Nullpunktgenauigkeit)

myNumFunc = size( theAimVals, 2);
for i=1:myNumFunc
	
	%Gewichte holen:
	if exist( 'theWeights', 'var') && ~isempty( theWeights)
		if( size( theWeights, 2) == myNumFunc)
			myWeights = diag( theWeights( :, i));
		else
			myWeights = diag( theWeights( :));
		end
	else
		myWeights = diag( ones( size( theAimVals, 1), 1));
	end

	%Fit und Datenübgergabe:
	theKoeffMatrix( :, i) = (myWeights*myPolynomMatrix)\(myWeights*theAimVals( :, i));

end

