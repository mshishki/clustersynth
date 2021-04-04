function theCAA = imXYZ2CAM02( theXYZ, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b)
% imXYZ2CAM02 computes the coordinates Lightness J, Chroma C, and hue angles 
% (in degrees) h in CIECAM02 space.
%
%Usage: theCAA = imXYZ2CAM02( theXYZ, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b);
% ----------------------------------------------------------------------------
%
% theXYZ = Relative tristimulus values of the samples.
%        For N colours, this is a Nx3 matrix or a YxXx3 Image.
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
% theCAA.J, .C, .h = [L C h(º)]. 
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
    
if exist( 'theY_b') == 0
    myY_b = theXYZ_W( 2) * 0.2; 
else
    myY_b = theY_b; 
end
    
if fImage
    myXYZ = reshape( theXYZ, [], 3);
else
    myXYZ = theXYZ;
end

%function theCAMControl = initializeCAMControl( theIllumination, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b)
myCAMControl_forward = initializeCAMControl( 0, theXYZ_W', ...
    theL_A, theLrel_surround, theFIllDiscount, myY_b);
myCAA = applyCAM_forward( myXYZ', myCAMControl_forward);

theCAA.J = myCAA.J;
theCAA.C = myCAA.C;
theCAA.h = myCAA.h;
