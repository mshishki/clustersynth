function theOutImage = repairMarker( theInImage, theMarkerMask, theControl)

theOutImage = theInImage;

SE = strel('disk', 3);
myBadMask = imdilate( theMarkerMask, SE);

for i= 1:size( theInImage, 3)
	theOutImage( : , :, i) = roifill( theInImage( : , :, i), myBadMask);
end


%Über imopen, aber helle Stellen bleiben unausgefüllt
% MarkerWidth = round( size( theLabImage, 1)/287 * 5);
% SE = strel( 'line', MarkerWidth, 0);
% LabCorr( : , :, 1) = imopen( LabImage( : , :, 1), SE);
% LabCorr( : , :, 2) = imopen( LabImage( : , :, 2), SE);
% LabCorr( : , :, 3) = imopen( LabImage( : , :, 3), SE);
% 
% SE = strel( 'line', MarkerWidth, 90);
% LabCorr( : , :, 1) = imopen( LabCorr( : , :, 1), SE);
% LabCorr( : , :, 2) = imopen( LabCorr( : , :, 2), SE);
% LabCorr( : , :, 3) = imopen( LabCorr( : , :, 3), SE);
% 
