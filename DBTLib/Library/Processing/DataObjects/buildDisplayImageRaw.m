function theDisplayImage = buildDisplayImageRaw( theImageData, theImageType, theDisplayControl)
%Definiert die Bilddarstellung für Rohbilder

myRawDisplayControl = theDisplayControl.Raw;

% Bilddaten über LUT anzeigen:

if( isfield( myRawDisplayControl, 'LUT'))

    %LUT wurde übergeben
    myLUT = myRawDisplayControl.LUT;
    myRawBWImage = myLUT( im2uint16( theImageData)+1);

elseif( isfield( myRawDisplayControl, 'Display'))
    if( isfield( myRawDisplayControl, 'Sensor'))
        myMin = myRawDisplayControl.Sensor.Range( 1);
        myMax = myRawDisplayControl.Sensor.Range( 2);
%         %Range checken und clippen
%         myRawBWImage = min( myMax, max( myMin, myRawBWImage));
    end
    
    myLUT = calcRawLUT( 0:2^16-1, ...
                    myRawDisplayControl.Display.StartBit, ...
                    myRawDisplayControl.Display.NumBits, ...
                    myRawDisplayControl.Display.Gamma);

    myRawBWImage = myLUT( im2uint16( theImageData)+1);
else
    myRawBWImage = theImageData;
end

%Bayer Pattern darstellen
theDisplayImage = raw2display( myRawBWImage, myRawDisplayControl);



function theLUT = calcRawLUT( theX, theStartBit, theNumBits, theGamma)
myMask = uint16( 2^theNumBits-1);

%Bit maskieren und downshiften
theBits = bitand( bitshift( uint16( theX), -(theStartBit-1)), myMask);

%Gamma noch anwenden
myBitMax = (2^theNumBits-1);
theLUT = uint8( 255 * ( double( theBits) / myBitMax).^(1/theGamma));
