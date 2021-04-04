function showLabDiffImages( theI1LabPatchImage, theCamLabPatchImage, theGridFactor, theInternalSizeFactor, theAdditiveTitle)

myProofImageI1 = imresize( imColorTransform( theI1LabPatchImage, '*Lab', '*sRGB'), theGridFactor, 'nearest');
myProofImageCam = imresize( imColorTransform( theCamLabPatchImage, '*Lab', '*sRGB'), theGridFactor, 'nearest');

% imdisplay( myProofImageI1, 'I1', 1);
% imdisplay( myProofImageCam, 'Cam', 1);
% 
[Y, X, C] = size( theI1LabPatchImage);
myMaskImage = zeros( Y*theGridFactor, X*theGridFactor, 'double');

%linker oberer Index:
theStart = (theGridFactor-theInternalSizeFactor)/2+1;
for i=1:Y
    myStartY = theStart+(i-1)*theGridFactor;
    for j=1:X
        myStartX = theStart+(j-1)*theGridFactor;
        myMaskImage( myStartY:myStartY+theInternalSizeFactor-1, myStartX:myStartX+theInternalSizeFactor-1) = 1;
    end
end
myMergedImage = myProofImageI1( :, :, 1) .* (-myMaskImage+1) + myProofImageCam( :, :, 1) .* myMaskImage;
myMergedImage( :, :, 2) = myProofImageI1( :, :, 2) .* (-myMaskImage+1) + myProofImageCam( :, :, 2) .* myMaskImage;
myMergedImage( :, :, 3) = myProofImageI1( :, :, 3) .* (-myMaskImage+1) + myProofImageCam( :, :, 3) .* myMaskImage;
imdisplay( myMergedImage, [ theAdditiveTitle, ' reference(outer)/actual'], 1);

% myMergedImageControl = myProofImageI1( :, :, 1) .* (-myMaskImage+1);
% myMergedImageControl( :, :, 2) = myProofImageI1( :, :, 2) .* (-myMaskImage+1);
% myMergedImageControl( :, :, 3) = myProofImageI1( :, :, 3) .* (-myMaskImage+1);
% imdisplay( myMergedImageControl, 'I1/CAM Control', 1);


% C = makecform('lab2srgb');
% theProofImageI1 = applycform( myI1LabPatchImage,C);
% theProofImageCam = applycform( myCamLabPatchImage,C);
% imdisplay( imresize( theProofImageI1, 10), 'I1', 1);
% imdisplay( imresize( theProofImageCam, 10), 'Cam', 1);
% 
% myDispImageI1 = softProof( myI1XYZPatchImage, 'LCMSXYZI.ICM', 'sRGBColorSpaceProfile.icm');
% myDispImageCam = softProof( myCamXYZPatchImage, 'LCMSXYZI.ICM', 'sRGBColorSpaceProfile.icm');
