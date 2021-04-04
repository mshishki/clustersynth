function theCAA = imXYZ2RLab( theXYZ, theXYZ_W, theL_W, theD, theSurroundGamma)
% imXYZ2RLab computes the coordinates L,a,b in RLab space, the chroma C and the
% hue angles (in degrees) h.
%
%Usage: theCAA = imXYZ2RLab( theXYZ, theXYZ_W, theL_W, theD, theSurroundGamma);
% ----------------------------------------------------------------------------
%
% theXYZ = Relative tristimulus values of the samples.
%        For N colours, this is a Nx3 matrix or a YxXx3 Image.
%
% theXYZ_W = Relative tristimulus values of the reference white.
%
% theL_W   = Luminance (cd/m2) of the reference white (1x1).
%
% theD and theSurroundGamma parameters reflecting the observation conditions:
%
% theD =
%   .....1 hard-copy, 
%   .....0 soft-copy, 
%   .....For other situations, give intermediate values between these two.
% theSurroundGamma = observation conditions
%     ...1/2.3 for average sourround
%     ...1/2.9 for dim surround, 
%     ...1/3.5 for dark surround.
%
% theCAA.RLab = [L a b C h(º)]. For N colours, this is a Nx5 matrix.
%

mySize = size( theXYZ);
if( size( mySize, 2) == 3)
    fImage = 1;
    Y = mySize( 1);
    X = mySize( 2);
    theCAA.ImSize.fImage = fImage;
    theCAA.ImSize.Y = Y;
    theCAA.ImSize.X = X;
else
    fImage = 0;
    Y = mySize( 1);
    theCAA.ImSize.fImage = fImage;
    theCAA.ImSize.Y = Y;
end
    
if fImage
    myXYZ = reshape( theXYZ, [], 3);
else
    myXYZ = theXYZ;
end

RLab = XYZ2RLab( myXYZ, theXYZ_W, theL_W, theD, theSurroundGamma);
theCAA.RLab = RLab;
