function theClippingLut = makeClippingLut( theMaxVal, theNormVal, theSoftnessGMFactor);

global gUINT16Max
myMaxVal = uint16( theMaxVal);

Norm = 2.5 - 2.0 * theSoftnessGMFactor;
Norm1 = 1.3 * Norm;
Norm2 = 2.5 * Norm;

x = double((0:myMaxVal)) ./ theNormVal;
result = 1.0 ./(1.0 + x.*(1.0-exp(-(( x/Norm2).^Norm1))));

theClippingLut( 2:myMaxVal+1) = int32( gUINT16Max * min( result( 2:myMaxVal+1), theNormVal ./ double(( 1:myMaxVal))));
theClippingLut( 1) = gUINT16Max;
end %makeClippingLut
