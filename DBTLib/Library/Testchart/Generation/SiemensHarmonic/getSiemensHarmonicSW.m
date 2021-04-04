function theSiemensImage = getSiemensHarmonicSW( theSize, theCycles)

BlackColor = [ 0, 0, 0];
WhiteColor = [ 1, 1, 1];

theSiemensImage = sinus_siemens_synthesizer( theSize, theCycles, WhiteColor, BlackColor);