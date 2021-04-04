function theTransformedImage = imColorTransformAbsolute( theInImage, IProf, OProf)
%Usage: theTransformedImage = imColorTransformWindows( theInImage, IProf, OProf);
%Hint: uses absolute colorimetric rendering intent

theTransformedImage = imColorTransform( theInImage, IProf, OProf, 'AbsoluteColorimetric');
