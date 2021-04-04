function [theCCSGRGB, theCropRegion, thePatches] = getRGBFromCCSGImage( theCCSGImage, theFilename, theGamma, fCrop)

if( ~isempty( theCCSGImage))
	
%Testchartanalyse
%------------------------

	if( exist( 'fCrop') && ~fCrop)
		myCropRect = [];
	else	
		%Cropping
		myCropFigH = imdisplay( theCCSGImage, 'Crop Testchart ROI:', theGamma);%Anzeige auf 16bit und Gamma 2.2 anpassen
		[ DumImage, myCropRect] = imcrop( myCropFigH);
	end
	if( ~isempty( myCropRect))
		myRGB4TCA = imcrop( theCCSGImage, myCropRect);
		close( myCropFigH);
		myCropFigH = imdisplay( myRGB4TCA, ' ', theGamma);
	else
		myRGB4TCA = theCCSGImage;
		myCropFigH = imdisplay( myRGB4TCA, ' ', theGamma);
	end	

	%Testchart abtasten
	myPatchesResult = analyzeColorCheckerSG( myRGB4TCA, theFilename, myCropFigH, theGamma);	%Normierung auf MaxWert 1
	close( myCropFigH);
	
	%gemessene RGB-Daten übernehmen:
	theCCSGRGB = getRGBs( myPatchesResult); 
	if nargout > 1
		theCropRegion = myCropRect;
	end
	if nargout > 2
		thePatches = myPatchesResult;
	end
else
	theCCSGRGB = [];
	if nargout > 1
		theCropRegion = [];
	end
	if nargout > 2
		thePatches = [];
	end
end
	
