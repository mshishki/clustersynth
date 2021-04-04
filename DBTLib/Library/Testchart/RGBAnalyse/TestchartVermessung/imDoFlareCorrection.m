function theFlareCorrectedImage = imDoFlareCorrection( theImage, theFlareLuts)
myLutAccuracy = 16; %16 bit Genauigkeit

%Bilddatei auswählen, falls nicht übergeben:
if ( (exist( 'theImage') == 0) || theImage ==0)
	% Bilddatei einlesen:
	[file, path] = uigetfile( '*.*', 'Wähle eine Bilddatei:');
	theImageFileName = [path, file];
    theImage = imread( theImageFileName);
end
myInputImage = im2uint16( theImage);


%LUT-Datei auswählen, falls nicht übergeben:
if ( (exist( 'theFlareLuts') == 0) || theFlareLuts ==0)
	% Lut-Datei einlesen:
	[file, path] = uigetfile( '*.mat', 'Wähle eine Flare Lut Datei:');
	theFLFileName = [path, file];
    myLoadFlareLuts = load( theFLFileName);
    theFlareLuts = myLoadFlareLuts.theFlareLuts;
end
myLutAccuracy = 16; %16 bit Genauigkeit
myLutMaxValue = theFlareLuts( 2^myLutAccuracy, :)
theFlareLutsR = theFlareLuts( :, 1);
theFlareLutsG = theFlareLuts( :, 2);
theFlareLutsB = theFlareLuts( :, 3);

analyze1D( (1:(2^myLutAccuracy))', theFlareLuts, 'FlareLuts');


myFCorrImage( :, :, 1) = theFlareLutsR( myInputImage( :, :, 1) + 1) / myLutMaxValue( 1);
myFCorrImage( :, :, 2) = theFlareLutsG( myInputImage( :, :, 2) + 1) / myLutMaxValue( 2);
myFCorrImage( :, :, 3) = theFlareLutsB( myInputImage( :, :, 3) + 1) / myLutMaxValue( 3);


if ( exist( 'theImageFileName') == 0)
	% Bilddateinamen eingeben:
	theImageFileName = chooseFile4Write( 'Bild speichern als:', '*.tif', '');
else
    theImageFileName = [ theImageFileName( 1:end-4), '_FlareCorr.tif'];
end

imwrite( im2uint16( myFCorrImage), theImageFileName, 'tif');
