function theFCImage = doFC( theRGBImage, theFlareFactor)
%Flare correction mit Streuanteil theFlareFactor

myMean = mean2( theRGBImage( : , :, 2));
myFlare = theFlareFactor * myMean;

theFCImage = theRGBImage - myFlare;

