function theLut8 = getLut8( theLut16)
myIndex = uint16( round(((0:255)/255 * 65535))+1);
theLut8 = uint8( round( double( theLut16( myIndex))/65535 * 255));