function theSiemensImage = sinus_siemens_synthesizer( theSize, theCycles, theColorHigh, theColorLow)

Amplitude = 0.5;
Mean = 0.5;
Cycles = theCycles;

XSize = theSize( 2);
YSize = theSize( 1);
X0 = XSize/2;
Y0 = YSize/2;

radius = zeros( XSize, YSize, 'double');
phi = zeros( XSize, YSize, 'double');
for y=1:YSize
    for x=1:XSize
        radius( y, x) = sqrt( (x-X0)^2 + (y-Y0)^2);
        phi( y, x) = Cycles * (atan( (x-X0) / (y-Y0+0.00000001)) + (sign( y-Y0)<0)*pi);%um Underflow zu vermeiden
    end
end

mySiemens = radius;
mySiemens( :, :) = (sin( phi( :, :)) * Amplitude) + Mean;

if( (theColorHigh(1) ~= theColorHigh(2)) ||  (theColorHigh(2) ~= theColorHigh(3)) ||  (theColorLow(1) ~= theColorLow(2)) ||  (theColorLow(1) ~= theColorLow(2)))
    %farbig:
    theSiemensImage = mySiemens;
    theSiemensImage( :, :, 1) = mySiemens * theColorHigh( 1) + (mySiemens*(-1) + 1) * theColorLow( 1);
    theSiemensImage( :, :, 2) = mySiemens * theColorHigh( 2) + (mySiemens*(-1) + 1) * theColorLow( 2);
    theSiemensImage( :, :, 3) = mySiemens * theColorHigh( 3) + (mySiemens*(-1) + 1) * theColorLow( 3);
else
    %SW:
    theSiemensImage( :, :) = mySiemens * theColorHigh( 1) + (mySiemens*(-1) + 1) * theColorLow( 1);    
end

%imwrite( mySiemens, 'SinusSiemens.tif', 'tif');
