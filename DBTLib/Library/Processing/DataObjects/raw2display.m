function theRawDisplayImage = raw2display( theSensorBWImage, theRaw2DispStruct)

[ myY, myX, myColors] = size( theSensorBWImage);
 
if( strcmp( theRaw2DispStruct.Display.ColorMode, 'BW'))
    %SW
    if( myColors == 3)
        %In SW-Bild wandeln
        myInputImage = (theSensorBWImage( :, :, 1) + theSensorBWImage( :, :, 2) + theSensorBWImage( :, :, 3)) / 3;
    else
        myInputImage = theSensorBWImage;
    end
    
    theRawDisplayImage( :, :, 1) = myInputImage;
    theRawDisplayImage( :, :, 2) = myInputImage;
    theRawDisplayImage( :, :, 3) = myInputImage;
    
else
    %Color
    if( myColors == 1)
        %In Farbbild wandeln
        myInputImage = zeros( myY, myX, 3, 'uint8');
        myInputImage( :, :, 1) = theSensorBWImage( :, :);
        myInputImage( :, :, 2) = theSensorBWImage( :, :);
        myInputImage( :, :, 3) = theSensorBWImage( :, :);
    else
        myInputImage = theSensorBWImage;
    end
    
    theRawDisplayImage = myInputImage;
    
    if strcmp( theRaw2DispStruct.Sensor.Mode, 'BP')
        %Farben löschen:
        myRedStart = theRaw2DispStruct.Sensor.RedStart;
        myGreen1Start = theRaw2DispStruct.Sensor.Green1Start;
        myGreen2Start = theRaw2DispStruct.Sensor.Green2Start;
        myBlueStart = theRaw2DispStruct.Sensor.BlueStart;
        %R: G=B=0
        theRawDisplayImage( myRedStart( 1):2:end, myRedStart( 2):2:end, 2:3) = 0;
        %G1: R=B=0
        theRawDisplayImage( myGreen1Start( 1):2:end, myGreen1Start( 2):2:end, 1) = 0;
        theRawDisplayImage( myGreen1Start( 1):2:end, myGreen1Start( 2):2:end, 3) = 0;
        %G2: R=B=0
        theRawDisplayImage( myGreen2Start( 1):2:end, myGreen2Start( 2):2:end, 1) = 0;
        theRawDisplayImage( myGreen2Start( 1):2:end, myGreen2Start( 2):2:end, 3) = 0;
        %B: R=G=0
        theRawDisplayImage( myBlueStart( 1):2:end, myBlueStart( 2):2:end, 1:2) = 0;
    end

end

