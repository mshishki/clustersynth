function [ theCam2XYZColorMatrix, theTf, theTint] = getColorMatrixFromDNG( theDNGHeader, theAsShotNeutral)
% optional: theTf, theTint

%Headerinformationen der Farbkalibrierung und für den Weißabgleich auslesen
%und als Struktur zusammenfassen
if isfield( theDNGHeader, 'AnalogBalance')
	ColorCalibData.Set( 1).AnalogBalance = theDNGHeader.AnalogBalance;
else
	ColorCalibData.Set( 1).AnalogBalance = [ 1; 1; 1];
end
if ~isfield( theDNGHeader, 'CameraCalibration1')
     ColorCalibData.Set( 1).CalibrationMatrix = eye( 3);
else
    ColorCalibData.Set( 1).CalibrationMatrix = reshape( theDNGHeader.CameraCalibration1, 3, 3)';
end
ColorCalibData.Set( 1).ColorMatrix = reshape( theDNGHeader.ColorMatrix1, 3, 3)';
ColorCalibData.Set( 1).Illuminant = theDNGHeader.CalibrationIlluminant1;

if isfield( theDNGHeader, 'AnalogBalance')
	ColorCalibData.Set( 2).AnalogBalance = theDNGHeader.AnalogBalance;
else
	ColorCalibData.Set( 2).AnalogBalance = [ 1; 1; 1];
end
if ~isfield( theDNGHeader, 'CameraCalibration1')
     ColorCalibData.Set( 2).CalibrationMatrix = eye( 3);
else
    ColorCalibData.Set( 2).CalibrationMatrix = reshape( theDNGHeader.CameraCalibration2, 3, 3)';
end
ColorCalibData.Set( 2).ColorMatrix = reshape( theDNGHeader.ColorMatrix2, 3, 3)';
ColorCalibData.Set( 2).Illuminant = theDNGHeader.CalibrationIlluminant2;

%Farbtemperatur iterativ bestimmen
[ Tf, Tint] = findTf( theAsShotNeutral, ColorCalibData);

%Farbmatrix als Funktion der Farbtemperatur interpolieren
theCam2XYZColorMatrix = getCam2XYZ( ColorCalibData, Tf);

if nargout > 1
	theTf = Tf;
end

if nargout > 2
	theTint = Tint;
end


