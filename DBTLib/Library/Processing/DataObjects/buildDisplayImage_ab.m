function theDisplayImage = buildDisplayImage_ab( theImageData, theImageType, theDisplayControl)

%L-Kanal auf mittleres Grau setzen:
myLabDouble = im2double( theImageData( :, :, 1));
myLabDouble( :, :, :) = 0;

switch( class( theImageData))
    case {'uint16', 'uint8'}
        myLabDouble( :, :, 2) = im2double( theImageData( :, :, 1)) - 0.5;
        myLabDouble( :, :, 3) = im2double( theImageData( :, :, 2)) - 0.5;
    otherwise
        myLabDouble( :, :, 2) = im2double( theImageData( :, :, 1));
        myLabDouble( :, :, 3) = im2double( theImageData( :, :, 2));
end

DrgbImage = imMatMul( myLabDouble, theDisplayControl.RGBLin2LogLab.invMatrix) - theDisplayControl.RGBLin2LogLab.DOffset;
theDisplayImage = buildDisplayImageRGB( DrgbImage, 'Log', theDisplayControl);

% RGBLinImage = 10.^( DrgbImage);
% theDisplayImage = buildDisplayImageRGB( RGBLinImage, 'Lin', theDisplayControl);

