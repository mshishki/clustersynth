function showCamColormatchingFunctions( theKoeffMatrix)

%Normspektralwertkurven 
XYZCurves_10nm = getXYZCurves_10nm();
plot1D3Spectral( XYZCurves_10nm, 'XYZ');

%Äquivalente Kameraempfindlichkeiten:
myEquivCMFs = XYZCurves_10nm * (inv( theKoeffMatrix')');
plot1D3Spectral( myEquivCMFs, 'CamXYZ');

