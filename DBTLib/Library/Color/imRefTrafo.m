function theOut = imRefTrafo( theIn, theRefDescriptor, theXYZWhitePoint)
%Usage: theOut = imRefTrafo( theIn, theRefDescriptor, theXYZWhitePoint);
%Example: myXYZ = imRefTrafo( theLab, 'lab2xyz', myWhiteXYZ);

%Trafo-Struktur erzeugen
if exist( 'theXYZWhitePoint')
    myTrafo = makecform( theRefDescriptor, 'WhitePoint', theXYZWhitePoint);
else
    myTrafo = makecform( theRefDescriptor);
end

theOut = applycform( theIn, myTrafo);

end %imRefTrafo

