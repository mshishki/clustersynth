function theMaxValue = getMaxValue( theImage)

if( isa( theImage, 'uint8'))
    theMaxValue = 255;
elseif( isa( theImage, 'uint16'))
    theMaxValue = 2^16-1;
elseif( isa( theImage, 'double'))
    theMaxValue = 1;
elseif( isa( theImage, 'single'))
    theMaxValue = 1;
else
    theMaxValue = -1;
end

    
   
