function theDisplayImage = buildDisplayImageRGB( theImageData, theImageType, theDisplayControl)

%Originale Bilddaten anzeigen:
if( isType( theImageType, 'Lin'))
    myGamma = theDisplayControl.Gamma;
else
    myGamma = 1;
end

% Gammakorrektur und Anzeige
if( myGamma ~= 1)
    myGammaLut = uint8( 255 * ((0:2^16-1) / (2^16-1)).^(1/myGamma));
    theDisplayImage = myGammaLut( im2uint16( theImageData)+1);
else
    theDisplayImage = im2uint8( theImageData);
end


