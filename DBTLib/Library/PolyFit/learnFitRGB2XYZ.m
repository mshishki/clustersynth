function theKoeffMatrix = learnFitRGB2XYZ( theXYZ, theRGB, theOrder, theFDeltaEWheight, theWeights)
%Usage:	theKoeffMatrix = learnFit( theXYZ, theRGB, theOrder, theFDeltaEWheight);
%		theFDeltaEWheight==1: use weights; ==0: don't use weights

%Grauachse:
load GreyPatches;  %alle Felder außer Randfelder

%Delta E Gewichte
if theFDeltaEWheight==1
	myDeltaEWeights = getDeltaEWeight( theXYZ, theXYZ( 28, :));
else
	myDeltaEWeights = ones( size( theXYZ, 1), 3, 'double');
end
myWeightsX =  myDeltaEWeights( :, 1);
myWeightsY =  myDeltaEWeights( :, 2);
myWeightsZ =  myDeltaEWeights( :, 3);

if exist( 'theWeights', 'var') && ~isempty( theWeights)
	if size( theWeights, 1) == size( theXYZ, 1)
		%Dimension ok, übernehmen
		if( size( theWeights, 2) == 1)
			myWeightsX = theWeights( :, 1) .* myDeltaEWeights( :, 1);
			myWeightsY = theWeights( :, 1) .* myDeltaEWeights( :, 2);
			myWeightsZ = theWeights( :, 1) .* myDeltaEWeights( :, 3);
		elseif( size( theWeights, 2) == 3)
			myWeightsX = theWeights( :, 1) .* myDeltaEWeights( :, 1);
			myWeightsY = theWeights( :, 2) .* myDeltaEWeights( :, 2);
			myWeightsZ = theWeights( :, 3) .* myDeltaEWeights( :, 3);
		else
			disp( 'theWeights dims don''t fit');
		end
	else
		disp( 'theWeights dims don''t fit');
	end
end
%Diagonalmatrix herstellen:
myWeightsX =  diag( myWeightsX( :));
myWeightsY =  diag( myWeightsY( :));
myWeightsZ =  diag( myWeightsZ( :));
		
%Polynom-Basisfunktionen holen:
myPolynomMatrix = getPolynomMatrix( theRGB, theOrder);
%Hinweis, daß kein Offset vorgesehen wird (Nullpunktgenauigkeit)

%Fit:
% myKoeffX = (inv( myPolynomMatrix' * myWeightsX.^2 * myPolynomMatrix) * myPolynomMatrix' * myWeightsX.^2) * theXYZ( :, 1);
% myKoeffY = (inv( myPolynomMatrix' * myWeightsY.^2 * myPolynomMatrix) * myPolynomMatrix' * myWeightsY.^2) * theXYZ( :, 2);
% myKoeffZ = (inv( myPolynomMatrix' * myWeightsZ.^2 * myPolynomMatrix) * myPolynomMatrix' * myWeightsZ.^2) * theXYZ( :, 3);
myKoeffX = (myWeightsX*myPolynomMatrix)\(myWeightsX*theXYZ( :, 1));
myKoeffY = (myWeightsY*myPolynomMatrix)\(myWeightsY*theXYZ( :, 2));
myKoeffZ = (myWeightsZ*myPolynomMatrix)\(myWeightsZ*theXYZ( :, 3));

%Datenübgergabe:
theKoeffMatrix = [ myKoeffX, myKoeffY, myKoeffZ];

