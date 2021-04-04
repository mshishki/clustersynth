function theRGBPoint = analyzeRGBPoint( theImage, theMaxValue, theMessage)

if( ~exist( 'theMessage', 'var') || isempty( theMessage))
	theMessage = 'Mark point:';
end

% Steuerung initialisieren
if( exist( 'theMaxValue') && ~isempty( theMaxValue))
	myMaxValue = theMaxValue;
else
	myMaxValue = getMaxValue( theImage);
end
myControl = initializeControlTCAnalysis( myMaxValue);
myControl.Testchart.CenterOn = 1; %Nachzentrieren abstellen
myControl.Testchart.CenterOn = 0; %Nachzentrieren abstellen
myControl.Testchart.NumX = 1;
myControl.Testchart.NumY = 1;

%Bild in float Typ wandeln
myTestchartImage = single( theImage)/myMaxValue;
%myTestchartImage = im2single( theImage);

% Markierungen setzen
imdisplay( myTestchartImage, theMessage, myControl.Display.Gamma);

myControl.Testchart.Markers = setMarkers( 1);
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

theRGBPoint = myPatchesResult.Mean * myMaxValue;

