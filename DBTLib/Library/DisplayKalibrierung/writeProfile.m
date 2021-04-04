function writeProfile( theICCFilename, theRGB2XYZMatrix, theXYZ_White, theXYZ_Black, theLutR, theLutG, theLutB)
% Funktion zum Schreiben eines ICC-Matrix-Profils gemäß Display-Modell der
% Vorlesung
% 
% Parameter: 
% theICCFilename: Dateiname inkl. Endung
% theRGB2XYZMatrix: XYZ-Matrix der Primärvalenzen
% theXYZ_White: Weißpunkt
% theXYZ_Black: Schwarzpunkt
% theLutR, theLutG, theLutB: Kennlinien RGB -> RGBLinear

uint16Max = 2^16-1;
int16Max = 2^15-1;

myTRCLength = 1024;

%Profil lesen
myProfile = iccread('WideGamutRGB.icc'); %('ICCProfiles/sRGB.icm');
%myProfileLUT = iccread( 'LutProfile.icc');

%Tags durch unsere Daten ersetzen

myProfile.Header.CMMType = 'none';
myProfile.Header.Version = '2.1.0';
myProfile.Header.DeviceClass = 'display';
myProfile.Header.ColorSpace = 'RGB';
myProfile.Header.ConnectionSpace = 'XYZ';
myProfile.Header.CreationDate = now;
myProfile.Header.DeviceManufacturer = 'IMP_';
myProfile.Header.Illuminant = getXYZWhite( getD50()) /100;
%myProfile.Header.Illuminant(myProfile.Header.Illuminant>1) = 1;
myProfile.Copyright = 'FHK_IMP';
myProfile.Description.String = theICCFilename( 1:end-3);
myProfile.MediaWhitePoint = theXYZ_White /100;
%myProfile.MediaWhitePoint(myProfile.MediaWhitePoint>1) = 1;
myProfile.MediaBlackPoint = theXYZ_Black /100;
%myProfile.AToB0.MFT = ;
%myProfile.AToB0.InputTables{1} = theLutR * 1000;
%myProfile.AToB0.InputTables{2} = theLutG * 1000;
%myProfile.AToB0.InputTables{3} = theLutB * 1000;

% %Primärvalenzen auf die ICC-Lichtfarbe D50 normieren:
% myRGB_D50 = inv( theRGB2XYZMatrix) * getXYZWhite( getD50())';
% myRGB_D50Norm = myRGB_D50 / max( myRGB_D50(:));
% 
% myProfile.MatTRC.RedColorant = ( theRGB2XYZMatrix (:,1)' * myRGB_D50Norm( 1))/100;
% myProfile.MatTRC.GreenColorant = ( theRGB2XYZMatrix (:,2)' * myRGB_D50Norm( 2))/100;
% myProfile.MatTRC.BlueColorant = ( theRGB2XYZMatrix (:,3)' * myRGB_D50Norm( 3))/100;

%CAT
CRM = [0.8951, 0.2664, -0.1614; -0.7502, 1.7135, 0.0367; 0.0389, -0.0685, 1.0296];
InvCRM = inv( CRM);

Xdw = theXYZ_White( 1);
Ydw =  theXYZ_White( 2);
Zdw =  theXYZ_White( 3);



Xsw = myProfile.Header.Illuminant( 1);
Ysw = myProfile.Header.Illuminant(2);
Zsw = myProfile.Header.Illuminant(3);

DW = CRM * [Xdw; Ydw; Zdw];
SW = CRM * [Xsw; Ysw; Zsw];
DWSWMatrix = diag( DW./SW);

Bradford = InvCRM * DWSWMatrix * CRM;
RGB2XYZ2= inv( theRGB2XYZMatrix) * Bradford;
D50RGB2XYZ = inv(RGB2XYZ2);

D50RGB2XYZNorm = D50RGB2XYZ / max( D50RGB2XYZ(:));
%CAT END


myProfile.MatTRC.RedColorant = (D50RGB2XYZNorm(:,1)');
myProfile.MatTRC.GreenColorant = (D50RGB2XYZNorm(:,2)');
myProfile.MatTRC.BlueColorant = (D50RGB2XYZNorm(:,3)');


%TRC-Kurven in 10 bit Genauigkeit erstellen
x = round( (0:(myTRCLength-1))/(myTRCLength-1)*uint16Max);

myProfile.MatTRC.RedTRC = round( theLutR( x+1) * uint16Max);
myProfile.MatTRC.GreenTRC = round( theLutG( x+1) * uint16Max);
myProfile.MatTRC.BlueTRC = round( theLutB( x+1) * uint16Max);

myProfile.Filename = theICCFilename;


myProfile
myProfile.MatTRC
plot1D3( [ myProfile.MatTRC.RedTRC( :), ...
	myProfile.MatTRC.GreenTRC( :), ...
	myProfile.MatTRC.BlueTRC( :)]);
%myProfile.MatTRC.RedTRC = 2000;
%myProfile.MatTRC.GreenTRC = 2000;
%myProfile.MatTRC.BlueTRC = 2000;

%Profil schreiben
iccwrite( myProfile, theICCFilename);


% %Profil lesen
% % myProfileMatrix = iccread( 'MatrixProfile.icc');
% % myProfileLUT = iccread( 'LutProfile.icc');
% myProfile = iccread( 'EW-sRGB');
% 
% %Tags durch unsere Daten ersetzen
% 
% %myProfile.Header.Illuminant = XYZD50;
% myProfile.ChromaticAdaptation = eye( 3);
% myProfile.MediaWhitePoint = myXYZ_WP / myXYZ_WP(2);
% myProfile.MediaBlackPoint = [0.3, 0.3, 0.3];%myXYZ_BP / myXYZ_WP(2);
% %myProfile.Luminance = XYZD50;
% myProfile.MatTRC.RedMatrixColumn = myRGB2XYZMatrix( :, 1);
% myProfile.MatTRC.GreenMatrixColumn = myRGB2XYZMatrix( :, 2);
% myProfile.MatTRC.BlueMatrixColumn = myRGB2XYZMatrix( :, 3);
% myProfile.MatTRC.RedTRC = myLutR*uint16Max;
% myProfile.MatTRC.GreenTRC = myLutG*uint16Max;
% myProfile.MatTRC.BlueTRC = myLutB*uint16Max;
% 
% %Profil schreiben
% iccwrite( myProfile, theICCFilename);
