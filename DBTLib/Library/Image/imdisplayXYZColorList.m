function imdisplayXYZColorList( theXYZList, theXYZ_W, theWindowTitle)
%Usage: imdisplayXYZColorList( theXYZImage, theXYZ_W, theWindowTitle);
%Hint: To avoid chromatic adaptation by the wrong Von Kries transform,
%      the whitepoint has to match the whitepoint of sRGB (D65).

myLowResXYZImage = formatImage( theXYZList);
myImageLab = imXYZ2Lab( myLowResXYZImage, theXYZ_W);
mysRGBReproImage = imColorTransform( myImageLab, '*Lab', '*sRGB');

if exist( 'theWindowTitle')==0 
    imdisplay( imresize( mysRGBReproImage, 20, 'nearest'));
else
    imdisplay( imresize( mysRGBReproImage, 20, 'nearest'), theWindowTitle);
end
