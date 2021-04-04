function theTransformedImage = imColorTransform( theInImage, IProf, OProf, theRenderingIntent)
%Usage: theTransformedImage = imColorTransform( theInImage, IProf, OProf);
%Hint: default: uses relative colorimetric rendering intent
%'AbsoluteColorimetric', 'Perceptual', 'RelativeColorimetric', or 'Saturation'

if nargin>3
	myRI = theRenderingIntent;
else
	myRI = 'RelativeColorimetric';
end

%Umwandlung bei single-Typ:
if isa( theInImage, 'single')
	theInImage = im2double( theInImage);
end

% nur eine von beiden:
if ispc
	theTransformedImage = imColorTransformWindows( theInImage, IProf, OProf, myRI);
else
	theTransformedImage = imColorTransformMac( theInImage, IProf, OProf, myRI);
end
