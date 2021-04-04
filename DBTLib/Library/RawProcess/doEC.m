function theECImage = doEC( theRGBImage, theUserFactor, theMode)
%Exposure correction

% Modi: Fix: nicht adaptiv
%		Adaptive: Abhängig vom Bildinhalt

if ~exist( 'theMode')
	%default
	theMode = 'Fix';
end

switch theMode
	case 'Fix'
		myFactor = 1;
	otherwise
		myMean = mean2( log( single( theRGBImage( : , :, 2)) + 0.000000001));
		myFactor = exp( -myMean + log( 0.18))/sqrt( 2);
end

theECImage = theRGBImage * myFactor * theUserFactor;
