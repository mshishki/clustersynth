function theChroma = rgb2chroma( theRGB)

% Berechnung der Farbverhältnisse 
myRGBSum = sum( theRGB);
theChroma( 1) = theRGB( 1) ./ myRGBSum;
theChroma( 2) = theRGB( 2) ./ myRGBSum;
theChroma( 3) = theRGB( 3) ./ myRGBSum;

theChroma( find( isinf( theChroma))) = 0;	%passiert nur in allen 3 Kanälen gleichzeitig
