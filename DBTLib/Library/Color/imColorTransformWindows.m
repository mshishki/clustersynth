function theTransformedImage = imColorTransformWindows( theInImage, IProf, OProf, theRI)
%Usage: theTransformedImage = imColorTransformWindows( theInImage, IProf, OProf, theRI);
%'AbsoluteColorimetric', 'Perceptual', 'RelativeColorimetric', or 'Saturation'

if( exist( IProf, 'file'))
	mySourceProfile = which( IProf);
else
	mySourceProfile = IProf;
end
if( exist( OProf, 'file'))
	myDestProfile = which( OProf);
else
	myDestProfile = OProf;
end

if( ~exist( 'theRI') || isempty( theRI))
	%default RelativeColorimetric
	myOpt = ['-t1 -i ', mySourceProfile, ' -o ', myDestProfile];
else	
	switch theRI
		case 'AbsoluteColorimetric'
			myOpt = ['-t3 -i ', mySourceProfile, ' -o ', myDestProfile];
		case 'Perceptual'
			myOpt = ['-t0 -i ', mySourceProfile, ' -o ', myDestProfile];
		case 'RelativeColorimetric'
			myOpt = ['-t1 -i ', mySourceProfile, ' -o ', myDestProfile];
		case 'Saturation'
			myOpt = ['-t2 -i ', mySourceProfile, ' -o ', myDestProfile];
		otherwise
			myOpt = ['-t1 -i ', mySourceProfile, ' -o ', myDestProfile];
	end
end

if isa( theInImage, 'single')
	theInImage = im2double( theInImage);
end

%im Fall Schwarzweiß auf 3 gleiche Auszüge erweitern
if (size( theInImage, 3)==1) && (size( theInImage, 2)~=3)
	theInImage( :, :, 2) = theInImage( :, :, 1);
	theInImage( :, :, 3) = theInImage( :, :, 1);
end

warning off MATLAB:mex:deprecatedExtension
theTransformedImage = icctrans( theInImage, myOpt);
warning on MATLAB:mex:deprecatedExtension
