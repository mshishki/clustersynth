function [theCamRGBImage, theRawImageOut, theTotalFileNameOut] = convertRaw2CamTiff( theTotalFileName, theRawImage)
%Usage: [theCamRGBImage, theRawImage, theTotalFileName] = convertRaw2CamTiff( theTotalFileName, theRawImage);
%Optional input: theTotalFileName, theRawImage
%Optional output: theRawImageOut, theTotalFileNameOut
%Description: loads raw image and applies demosaicking

if exist( 'theTotalFileName')
    myTotalFileName = theTotalFileName;
else
    %Bildauswahl:
    [myTotalFileName, myStatus] = getRawFile4Read( '*.CR2');
    if myStatus==0
        return;
    end
end

if exist( 'theRawImage')
    myRawImage = theRawImage;
else
    %Bild laden:
    myRawImage = getRawImages( myTotalFileName);
end

% Demosaicking anwenden:
theCamRGBImage = getDemosaickedRaw( myRawImage, myTotalFileName);

if nargout > 1
    theRawImageOut = myRawImage;
end

if nargout > 2
    theTotalFileNameOut = myTotalFileName;
end