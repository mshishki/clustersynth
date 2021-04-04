function theDisplayImage = buildDisplayImage_abSingle( theImageData, theImageType, theDisplayControl)

% Gammakorrektur und Anzeige
myGamma = theDisplayControl.Gamma;
myGammaLut = uint8( 255 * ((0:2^16-1) / (2^16-1)).^(1/myGamma));

switch( class( theImageData))
    case 'double'
        theDisplayImage = myGammaLut( im2uint16( theImageData + 0.5) +1);
    case {'uint16', 'uint8'}
        theDisplayImage = myGammaLut( im2uint16( theImageData)+1);
    otherwise
        theDisplayImage = uint8( theImageData);
end


