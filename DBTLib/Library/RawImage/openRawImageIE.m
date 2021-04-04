function [theRawImage, theTotalFileNameOut] = openRawImageIE( theTotalFileName)
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
        return;
    end
end

%Bild laden:
theRawImage = getRawImages( myTotalFileName);

if nargout > 1
    theTotalFileNameOut = myTotalFileName;
end