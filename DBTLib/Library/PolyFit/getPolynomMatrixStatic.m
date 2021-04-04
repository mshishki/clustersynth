function thePolynomMatrix = getPolynomMatrixStatic( theRGB, thePolyOrder, theWeights)

myDim = size( theRGB, 2);
myCombExpArray = getCombExpArray( myDim, thePolyOrder, 'Static');

myNumFuncs = size( myCombExpArray, 1);
myNumVars = size( myCombExpArray, 2);

myFunc = (theRGB( :, 1).^myCombExpArray( 1, 1));
for j=2:myNumVars
	myFunc = myFunc .* (theRGB( :, j).^myCombExpArray( 1, j));
end
myFuncField = myFunc;

for i=2:myNumFuncs
	myFunc = (theRGB( :, 1).^myCombExpArray( i, 1));
	for j=2:myNumVars
		myFunc = myFunc .* (theRGB( :, j).^myCombExpArray( i, j));
	end
	
	myFuncField = [myFuncField, myFunc];
end

if nargin==3
	% Gewicht:
	myFuncField( :, :) = myFuncField( :, :) .* (theWeights * ones( 1, size( myFuncField, 2)));
end

thePolynomMatrix = myFuncField;

