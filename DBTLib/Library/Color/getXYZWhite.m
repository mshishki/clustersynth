function theXYZ_WP = getXYZWhite( theIllumination)
%Usage: theXYZ_WP = getXYZWhite( theIllumination);

%Wei�spektrum konstruieren
myWhite = 380:10:730;
myWhite( :) = 1;

theXYZ_WP = simXYZfromSpectra( myWhite, theIllumination);
