function theFigureHandle = imdisplay( theImage, theWindowTitle, theGamma)
% usage:                    imdisplay( theImage, theWindowTitle, theGamma);
% optional:                 theWindowTitle, theGamma
% Beschreibung:             Bildanzeige mit Gamma-Anpassung
% theImage:                 Eingangsbild
% theWindowTitle:           Fensterüberschrift (String)
% theGamma:                 Gamma-Wert
% Beispiel:                 imdisplay( myImage, 'Mein Bild:', 2.2);

persistent myGamma4Lut myGammaLut
if isempty( myGamma4Lut)
	myGamma4Lut = 1;
end

% Variable Argumente
if( nargin == 1)
	myGamma = 1;
	myWindowTitle = '';
end
if( nargin == 2)
    if( isnumeric( theWindowTitle))
        myGamma = theWindowTitle;
        myWindowTitle = '';
    else
        myGamma = 1;
        myWindowTitle = theWindowTitle;
    end
end
if( nargin == 3)
    if( ischar( theWindowTitle) && isnumeric( theGamma))
        myGamma = theGamma;
        myWindowTitle = theWindowTitle;
    elseif( ischar( theGamma) && isnumeric( theWindowTitle)) 
        myGamma = theWindowTitle;
        myWindowTitle = theGamma;
    else
        disp( 'Bad parameters (imdisplay()). Using defaults.');
        myGamma = 1;
        myWindowTitle = '';
    end
end

%GammaLut berechnen wenn nötig
if isempty( myGammaLut) && myGamma~=1 && myGamma~=myGamma4Lut
    myGammaLut = uint8( 255 * ((0:2^16-1) / (2^16-1)).^(1/myGamma));
	myGamma4Lut = myGamma;
end


%Default für Fenstertitel ist die Variablenbezeichnung
if( isempty( myWindowTitle))
	myWindowTitle = inputname( 1);
end

% Fenster öffnen
myScreenSize = get(0,'ScreenSize');

if( isempty( myWindowTitle))
    theFigureHandle = figure('Position',[1 1 myScreenSize(3) myScreenSize(4)]);
else
    % WindowTitle ist da
    theFigureHandle = figure('Position',[1 1 myScreenSize(3) myScreenSize(4)], 'Name', myWindowTitle, 'NumberTitle', 'off');
end

%iptsetpref( 'ImshowBorder', 'tight');
warning off Images:truesize:imageTooBigForScreen;
warning off Images:initSize:adjustingMag;

% Gammakorrektur und Anzeige
if( myGamma ~= 1)
    myGammaLut = uint8( 255 * ((0:2^16-1) / (2^16-1)).^(1/myGamma));
	myGamImage = im2uint16( theImage)+1;
	myGamImage8 =  myGammaLut( myGamImage);
    imshow( myGamImage8, 'InitialMagnification', 100);
%    imshow( myGamImage8, 'Border', 'tight', 'InitialMagnification', 100);
%	axes( 'ActivePositionProperty', 'OuterPosition');
else
    imshow( theImage, 'InitialMagnification', 100);
%    imshow( theImage, 'Border', 'tight', 'InitialMagnification', 100);
end

%truesize;
warning on Images:truesize:imageTooBigForScreen;
warning on Images:initSize:adjustingMag;

end