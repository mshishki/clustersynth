function thePolynomMatrix = getPolynomMatrix( theRGB, thePolyOrder, theStaticMode, theWeights)
%theStaticMode: 'Static' or 'noStatic'
%Static: with Offset; noStatic: no Offset

if exist( 'theStaticMode', 'var') && ~isempty( theStaticMode)
	myMode = theStaticMode;	
else
	myMode = 'noStatic';	%default no Offset
end
	
myDim = size( theRGB, 2);
myCombExpArray = getCombExpArray( myDim, thePolyOrder, myMode);

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

if exist( 'theWeights', 'var') && ~isempty( theWeights)
	% Gewicht:
	myFuncField( :, :) = myFuncField( :, :) .* (theWeights * ones( 1, size( myFuncField, 2)));
end

thePolynomMatrix = myFuncField;

