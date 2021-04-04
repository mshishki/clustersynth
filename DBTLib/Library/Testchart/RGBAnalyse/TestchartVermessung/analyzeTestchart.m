function analyzeTestchart()

% Alle Figures schließen
close all hidden

% Bild öffnen
myTestchartImageName = chooseFile4Read( 'Choose testchart image:', '*.*', '');
if( myTestchartImageName) 
	myTestchartImage = imread( myTestchartImageName);
else
	exit;
end

% Steuerung initialisieren
myMaxValue = getMaxValue( myTestchartImage);
myControl = initializeControlTCAnalysis( myMaxValue);

% Markierungen setzen
imdisplay( myTestchartImage, 'Mark the centers of the 4 patches at the corners:', myControl.Display.Gamma);
myControl.Testchart.Markers = setMarkers();
if( myControl.Testchart.CenterOn)
    myControl.Testchart.Markers = centerMarkers( myTestchartImage, myControl.Testchart.Markers, myControl.Testchart);
end
myControl.Testchart.Markers = orderMarkers( myControl.Testchart.Markers, myControl.Testchart);

% Grid und Bereiche der Patches festlegen
myRectPatches = getRectPatches( myControl.Testchart.Markers, myControl.Testchart);

% Auszuwertende Bereiche freistellen und als Datenstruktur zusammenfassen
[ myPatchCollection, myPatchImage] = collectPatches( myTestchartImage, myRectPatches, myControl.Testchart);
imdisplay( myPatchImage, 'PatchImage', myControl.Display.Gamma);

% Zwischenergebnis abspeichern

% Bildbereiche auswerten (Mittelwerte, Standardabweichungen)
myPatchesResult = analyzePatches( myPatchCollection);

% Ergebnisse abspeichern 
savePatchResults( myPatchesResult, myControl, myPatchImage, myTestchartImageName);



end