function checkGreyAxis( theY, theRGB)
%Usage: checkGreyAxis( theY, theRGB);

plot1D3( getGreyPatches( theRGB), getGreyPatches( theY), ['r', 'g', 'b'], 'Grey Axis');

