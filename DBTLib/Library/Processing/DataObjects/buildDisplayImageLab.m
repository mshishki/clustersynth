function theDisplayImage = buildDisplayImageLab( theImageData, theImageType, theDisplayControl)

switch( class( theImageData))
    case {'uint16', 'uint8'}
        myLabDouble = im2double( theImageData);
        myLabDouble( :, :, 2) = myLabDouble( :, :, 2) - 0.5;
        myLabDouble( :, :, 3) = myLabDouble( :, :, 3) - 0.5;
    otherwise
        myLabDouble = im2double( theImageData);
end

DrgbImage = imMatMul( myLabDouble, theDisplayControl.RGBLin2LogLab.invMatrix) - theDisplayControl.RGBLin2LogLab.DOffset;
theDisplayImage = buildDisplayImageRGB( DrgbImage, 'Log', theDisplayControl);

% RGBLinImage = 10.^( DrgbImage);
% theDisplayImage = buildDisplayImageRGB( RGBLinImage, 'Lin', theDisplayControl);

