function theTransformedImage = imColorTransformPerceptual( theInImage, IProf, OProf)
%Usage: theTransformedImage = imColorTransformWindows( theInImage, IProf, OProf);
%Hint: uses perceptual rendering intent

myOpt = ['-t0 -i ', IProf, ' -o ', OProf];

warning off MATLAB:mex:deprecatedExtension
theTransformedImage = icctrans( theInImage, myOpt);
warning on MATLAB:mex:deprecatedExtension
