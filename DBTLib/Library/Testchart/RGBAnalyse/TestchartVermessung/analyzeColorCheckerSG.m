function thePatchesResult = analyzeColorCheckerSG( theCCImage, thePathPlusFilename, theFigure, theGamma)


% Steuerung initialisieren
myMaxValue = getMaxValue( theCCImage);
myControl = initializeControlTCAnalysisCCSG( myMaxValue);

if exist( 'theGamma')
	myGamma = theGamma;
else
	myGamma = myControl.Display.Gamma;
end;

% Markierungen setzen
if( exist( 'theFigure'))
	set( theFigure, 'Name', 'Mark the centers of the 4 patches at the corners:');
	figure( theFigure);
else
	imdisplay( theCCImage, 'Mark the centers of the 4 patches at the corners:', myControl.Display.Gamma);
end

myControl.Testchart.Markers = setMarkers();
if( myControl.Testchart.CenterOn)
    myControl.Testchart.Markers = centerMarkers( theCCImage, myControl.Testchart.Markers, myControl.Testchart);
end
myControl.Testchart.Markers = orderMarkers( myControl.Testchart.Markers, myControl.Testchart);

% Grid und Bereiche der Patches festlegen
myRectPatches = getRectPatches( myControl.Testchart.Markers, myControl.Testchart);

% Auszuwertende Bereiche freistellen und als Datenstruktur zusammenfassen
[ myPatchCollection, myPatchImage] = collectPatches( theCCImage, myRectPatches, myControl.Testchart);
imdisplay( myPatchImage, 'PatchImage', myGamma);

% Zwischenergebnis abspeichern

% Bildbereiche auswerten (Mittelwerte, Standardabweichungen)
myPatchesResult = analyzePatches( myPatchCollection);

% Ergebnisse abspeichern und übergeben
savePatchResults( myPatchesResult, myControl, myPatchImage, thePathPlusFilename);
thePatchesResult = myPatchesResult;

end