function [theRawImage, theTotalFileNameOut] = openRawImage( theTotalFileName)
%Usage: [theCamRGBImage, theRawImage, theTotalFileName] = openRawImage( theTotalFileName);
%Optional input: theTotalFileName
%Optional output: theTotalFileNameOut
%Description: loads raw image

if exist( 'theTotalFileName')
    myTotalFileName = theTotalFileName;
else
    %Bildauswahl:
    [myTotalFileName, myStatus] = getRawFile4Read( '*.*');
    if myStatus==0
        theRawImage = [];
        theTotalFileNameOut = [];
        return;
    end
end

%Bild laden:
theRawImage = getRawImages_2( myTotalFileName);

if nargout > 1
    theTotalFileNameOut = myTotalFileName;
end