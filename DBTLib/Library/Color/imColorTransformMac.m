function theTransformedImage = imColorTransformMac( theInImage, IProf, OProf, theRI)
%Usage: theTransformedImage = imColorTransformMac( theInImage, IProf, OProf, theRI);
%'AbsoluteColorimetric', 'Perceptual', 'RelativeColorimetric', or 'Saturation'

if( ~exist( 'theRI') || isempty( theRI))
	%default RelativeColorimetric
	myRI = 'RelativeColorimetric';
else
	myRI = theRI;
end

switch IProf
    case '*sRGB'
        myIProfStruct = iccread( 'ICCProfiles/D50_XYZ.icc');
        myInImage = imRefTrafo( theInImage, 'srgb2xyz');
    case '*Lab'
        myIProfStruct = iccread( 'ICCProfiles/D50_XYZ.icc');
        myInImage = imRefTrafo( theInImage, 'lab2xyz');
    case '*XYZ'
        myIProfStruct = iccread( 'ICCProfiles/D50_XYZ.icc');
        myInImage = theInImage;
    otherwise
        if( strcmp( OProf, '*sRGB') || strcmp( OProf, '*XYZ') || strcmp( OProf, '*Lab') )
            myIProfStruct = iccread( IProf);
            %Trafo-Struktur erzeugen
            myTrafo = makecform( 'icc', myIProfStruct, iccread( 'ICCProfiles/D50_XYZ.icc'), ...
                                     'SourceRenderingIntent', myRI, 'DestRenderingIntent', myRI);
            %ICC Trafo anwenden:
            myInImage = applycform( theInImage, myTrafo);
        else 
            myIProfStruct = iccread( IProf);
            myInImage = theInImage;
        end
end

switch OProf
    case '*sRGB'
        myIProf = 'ICCProfiles/D50_XYZ.icc';
        myOutImage = imRefTrafo( myInImage, 'xyz2srgb');
    case '*Lab'
        myIProf = 'ICCProfiles/D50_XYZ.icc';
        myOutImage = imRefTrafo( myInImage, 'xyz2lab');
    case '*XYZ'
        myIProf = 'ICCProfiles/D50_XYZ.icc';
        myOutImage = myInImage;
    otherwise
        %Trafo-Struktur erzeugen
        myTrafo = makecform( 'icc', myIProfStruct, iccread( OProf), ...
                                 'SourceRenderingIntent', myRI, 'DestRenderingIntent', myRI);
        %ICC Trafo anwenden:
        myOutImage = applycform( myInImage, myTrafo);
end

theTransformedImage = myOutImage;
