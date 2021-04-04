function theLab2 = imXYZ2Lab3( f, theXYZ_WP)
%Usage: theLab = imXYZ2Lab( theXYZ, theXYZWhitePoint);

%Trafo-Struktur erzeugen
if exist( 'theXYZ_WP')
    myTrafo = makecform( 'xyz2lab', 'WhitePoint', theXYZ_WP);
else
    myTrafo = makecform( 'xyz2lab');
end

theLab2 = applycform( f, myTrafo);

end %imXYZ2Lab
