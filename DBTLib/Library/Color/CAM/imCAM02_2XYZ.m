function theXYZ = imCAM02_2XYZ( theCAA, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b)
% imCAM02_2XYZ computes XYZ from the coordinates Lightness J, Chroma C, and hue angles 
% (in degrees) h in CIECAM02 space.
%
%Usage: theXYZ = imCAM02_2XYZ( theCAA, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b);
% ----------------------------------------------------------------------------
%
% theCAA.J, .C, .h = [L C h(º)]. 
%
% theXYZ_W = Relative tristimulus values of the reference white.
%
% theL_A   = Luminance (cd/m2) of the adapted white (1x1).
%
% theLrel_surround and theY_b parameters reflecting the observation conditions:
% theLrel_surround = observation conditions
%     'average' for average sourround
%     'dim' for dim surround, 
%     'dark' for dark surround.
% theY_b = relative Luminance of the background, is optional (default: theXYZ_W( 2) * 0.2)
%
% theFIllDiscount = flag for complete chromatic adaptation state.
%
% theXYZ = Relative tristimulus values of the samples.
%        For N colours, this is a Nx3 matrix or a YxXx3 Image.
%

if exist( 'theY_b') == 0
    myY_b = theXYZ_W( 2) * 0.2; 
else
    myY_b = theY_b; 
end
    
myCAMControl_backward = initializeCAMControl( 0, theXYZ_W', ...
    theL_A, theLrel_surround, theFIllDiscount, myY_b);
myXYZ = applyCAM_reverse( theCAA, myCAMControl_backward)';

if theCAA.ImSize.fImage
    Y = theCAA.ImSize.Y;
    X = theCAA.ImSize.X;
    theXYZ = reshape( myXYZ, Y, X, 3);
else
    theXYZ = myXYZ;
end
