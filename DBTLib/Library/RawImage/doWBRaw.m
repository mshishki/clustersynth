function [ theWBRawImage, theASNOut] = doWBRaw( theRawImage, theASN, theCFAPattern)
%White balance for DSC raw data
%theASN: RGB Values of an ideal white patch to be reproduced neutrally
%theCFAPattern: the bayer color filter array pattern, e.g. 'rggb'

Mask = zeros( size( theRawImage, 1), size( theRawImage, 2), 'uint8');
Mask11 = Mask;
Mask11( 1:2:end, 1:2:end) = 1;
Mask12 = Mask;
Mask12( 1:2:end, 2:2:end) = 1;
Mask21 = Mask;
Mask21( 2:2:end, 1:2:end) = 1;
Mask22 = Mask;
Mask22( 2:2:end, 2:2:end) = 1;

switch theCFAPattern
	case 'grbg'
		GrMask = Mask11;
		RMask = Mask12;
		BMask = Mask21;
		GbMask = Mask22;
	case 'rggb'
		RMask = Mask11;
		GrMask = Mask12;
		GbMask = Mask21;
		BMask = Mask22;
	case 'gbrg'
		GbMask = Mask11;
		BMask = Mask12;
		RMask = Mask21;
		GrMask = Mask22;
	case 'bggr'
		BMask = Mask11;
		GbMask = Mask12;
		GrMask = Mask21;
		RMask = Mask22;
	otherwise
		RMask = Mask11;
		GrMask = Mask12;
		GbMask = Mask21;
		BMask = Mask22;
end

if isempty( theASN)
	% WB-Faktoren bestimmen
	myRMean = mean2( theRawImage .* single( RMask)) * 4;
	myGMean = mean2( theRawImage .* single( GrMask+GbMask)) * 2;
	myBMean = mean2( theRawImage .* single( BMask)) * 4;
	
	theASN = [ myRMean, myGMean, myBMean] / myGMean;
end

%Weißabgleich auf CFA-RGB anwenden
theWBRawImage = theRawImage;
theWBRawImage( RMask>0) = theRawImage( RMask>0) / theASN( 1);
theWBRawImage( BMask>0) = theRawImage( BMask>0) / theASN( 3);

if nargout>1
	theASNOut = theASN;
end


