function theRGBMean = immeanrect( theImage, theRect, theCFAPattern, theFShow)
% optional: theCFAPattern

if exist( 'theCFAPattern') && ~isempty( theCFAPattern)
	myRGBImage = demosaic( im2uint16( theImage), theCFAPattern);
else
	myRGBImage = theImage;
end

myROI = imcrop( myRGBImage, theRect);

if exist( 'theFShow') && theFShow == 1
	imdisplay( myROI, 2.2);
end

theRGBMean = mean( mean( myROI));
theRGBMean = theRGBMean(:);
