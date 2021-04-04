function theLab = imXYZ2Lab2( theXYZTest, theXYZ_WP)
%Usage: theLab = imXYZ2Lab( theXYZ, theXYZWhitePoint);

%Trafo-Struktur erzeugen
if exist('theXYZ_WP')
    myTrafo = makecform( 'xyz2lab', 'WhitePoint', theXYZ_WP);
else
    myTrafo = makecform( 'xyz2lab');
end

theLab = applycform( theXYZTest, myTrafo);

end %imXYZ2Lab
