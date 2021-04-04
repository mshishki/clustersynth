function theXYZ = imRLab_2XYZ( theCAA, theXYZ_W, theL_W, theD, theSurroundGamma)
% RLAB2XYZ computes the tristimulus values from the lightness, chroma and hue
% in the Rlab space.
%
%Usage: theXYZ = imRLab_2XYZ( theCAA, theXYZ_W, theL_W, theD, theSurroundGamma);
% ----------------------------------------------------------------------------
%
% theCAA  = Color Appearance Attributes of imXYZ2RLab()
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
% theXYZ = Relative tristimulus values of the samples.
%           For N colours, this is a Nx3 matrix, or it is a XYZ image.

myXYZ = RLab2XYZ( [theCAA.RLab( :, 1), theCAA.RLab( :, 4), theCAA.RLab( :, 5)], theXYZ_W, theL_W, theD, theSurroundGamma);

if theCAA.ImSize.fImage
    Y = theCAA.ImSize.Y;
    X = theCAA.ImSize.X;
    theXYZ = reshape( myXYZ, Y, X, 3);
else
    theXYZ = myXYZ;
end
