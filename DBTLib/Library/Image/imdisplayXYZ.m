function imdisplayXYZ( theXYZImage, theXYZ_W, theWindowTitle)
%Usage: imdisplayXYZ( theXYZImage, theXYZ_W, theWindowTitle);
%Hint: To avoid chromatic adaptation by the wrong Von Kries transformation,
%      the whitepoint has to match the whitepoint of sRGB (D65).

myImageLab = imXYZ2Lab( theXYZImage, theXYZ_W);
mysRGBReproImage = imColorTransform( myImageLab, '*Lab', '*sRGB');
imdisplay( mysRGBReproImage, theWindowTitle);
