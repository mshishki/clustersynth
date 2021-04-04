function theXYZ = imLab2XYZ( theLab, theXYZWhitePoint)
%Usage: theXYZ = imLab2XYZ( theLab, theXYZWhitePoint);

%Trafo-Struktur erzeugen
if exist( 'theXYZWhitePoint')
    myTrafo = makecform( 'lab2xyz', 'WhitePoint', theXYZWhitePoint);
else
    myTrafo = makecform( 'lab2xyz');
end

theXYZ = applycform( theLab, myTrafo);

end %imLab2XYZ

