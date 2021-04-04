function theLab = imXYZ2Lab( theXYZ, theXYZWhitePoint)
%Usage: theLab = imXYZ2Lab( theXYZ, theXYZWhitePoint);

%Trafo-Struktur erzeugen
if exist( 'theXYZWhitePoint')
    myTrafo = makecform( 'xyz2lab', 'WhitePoint', theXYZWhitePoint);
else
    myTrafo = makecform( 'xyz2lab');
end

theLab = applycform( theXYZ, myTrafo);

end %imXYZ2Lab

