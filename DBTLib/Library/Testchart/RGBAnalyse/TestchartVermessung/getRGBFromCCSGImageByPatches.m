function [theCCSGRGB, theCropRegion, thePatches] = getRGBFromCCSGImageByPatches( theCCSGImage, theCropRect, thePatchesInput)

if( ~isempty( theCCSGImage))
	
	%Testchartanalyse
	%------------------------
	%Cropping
	if( ~isempty( theCropRect))
		myRGB4TCA = imcrop( theCCSGImage, theCropRect);
	else
		myRGB4TCA = theCCSGImage;
	end	

	%Testchart abtasten
	
	% Steuerung initialisieren
	myMaxValue = getMaxValue( myRGB4TCA);
	myControl = initializeControlTCAnalysisCCSG( myMaxValue);
	
	myRows = size( thePatchesInput, 1);
	myCols = size( thePatchesInput, 2);
	myRectPatches = zeros( myRows, myCols, 4, 'uint16');
	for i=1:myRows
		for j=1:myCols
			myRectPatches( i, j, 1:4) = thePatchesInput( i, j).PatchRect;
		end
	end

	% Auszuwertende Bereiche freistellen und als Datenstruktur zusammenfassen
	[ myPatchCollection, myPatchImage] = collectPatches( myRGB4TCA, myRectPatches, myControl.Testchart);

	% Zwischenergebnis abspeichern

	% Bildbereiche auswerten (Mittelwerte, Standardabweichungen)
	myPatchesResult = analyzePatches( myPatchCollection);
	
	%gemessene RGB-Daten übernehmen:
	theCCSGRGB = getRGBs( myPatchesResult); 
	if nargout > 1
		theCropRegion = theCropRect;
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
	
