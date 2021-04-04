function [ theRGBMean,  thePatchesResultOut] = getRGBs( thePatchesResult)
%usage: [ theRGBMean,  thePatchesResultOut] = getRGBs( thePatchesResult);
%optional: thePatchesResultOut

if ( ~exist( 'thePatchesResult') || isempty( thePatchesResult))
	% Results einlesen:
	[file, path] = uigetfile( '*.mat', 'Wähle eine PatchesResult-Datei:');
	temp = load( [path, file]);		%Aus Matlabgründen temp nochmals zuweisen.
	thePatchesResult = temp.TestchartResults;
end

[ myNumY, myNumX] = size( thePatchesResult);
%[ myNumY, myNumX] = size( thePatchesResult.Patches);


myRGBs = zeros( myNumY*myNumX, 3, 'double');
for zeile = 1:myNumY
	for spalte = 1:myNumX
		for farbe = 1:3
			myRGBs( zeile + (spalte-1)*myNumY, farbe) = thePatchesResult( zeile, spalte).Mean( farbe);
%			myRGBs( zeile + (spalte-1)*myNumY, farbe) = thePatchesResult.Patches( zeile, spalte).Mean( farbe);
		end
	end
end

theRGBMean = myRGBs;
if nargout>1
	thePatchesResultOut = thePatchesResult;
end
