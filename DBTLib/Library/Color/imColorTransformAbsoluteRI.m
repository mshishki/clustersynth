function theTransformedImage = imColorTransformAbsoluteRI( theInImage, IProf, OProf)
%Usage: theTransformedImage = imColorTransformAbsoluteRI( theInImage, IProf, OProf);
%Hint: uses absolute colorimetric rendering intent

myOpt = ['-t3 -i ', IProf, ' -o ', OProf];

warning off MATLAB:mex:deprecatedExtension
theTransformedImage = icctrans( theInImage, myOpt);
warning on MATLAB:mex:deprecatedExtension
