function [output] = doFastDemosaic(input)
% Bilinear Interpolation of the missing pixels
% Bayer CFA
%       R G R G
%       G B G B
%       R G R G 
%       G B G B
%
% The input can be on one channel, uint16 or double
%
% Output = a complete RGB image on 3 channels, half the size of the input
% image

%even number of rows and cols:
[NumY, NumX, c] = size( input);
if mod( NumY, 2)
    input( end, :) = [];
end
if mod( NumX, 2)
    input( :, end) = [];
end

%color separation
myR = input( 1: 2: end, 1: 2: end);
myGr = input( 1: 2: end, 2: 2: end);
myGb = input( 2: 2: end, 1: 2: end);
myB = input( 2: 2: end, 2: 2: end);


if class( input) == 'uint16'
    myG = uint16( (int32( myGr) + int32( myGb)) / 2);
elseif class( input) == 'double'
    myG = ( myGr + myGb) / 2;
elseif class( input) == 'single'
    myG = ( myGr + myGb) / 2;
else
    output = [];
    return;
end

output = zeros( NumY/2, NumX/2, 3, class( input));
output( :, :, 1) = myR;
output( :, :, 2) = myG;
output( :, :, 3) = myB;
