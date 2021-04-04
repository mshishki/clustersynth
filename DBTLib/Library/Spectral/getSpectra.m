function [theSpectra, theRGB] = getSpectra( theSpectraName, theWavelengthVector)
%Usage: [theSpectra, theRGB] = getSpectra( theSpectraName, theWavelengthVector);
%Optional: theRGB
%Keywords for theSpectraName: 
%		'ColorChecker'
%		'Krinov'
%		'Surfaces'
%		'VrhelDupontPaintChips'
%		'VrhelMunsellChips'
%		'VrhelNaturalObjects'
%		'All'
%		'Vrhel'

%load( 'Spectra/SpectralDataSet.mat');

switch( theSpectraName)
	case 'ColorChecker'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = ColorChecker;
	case 'Krinov'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = Krinov;
	case 'Surfaces'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = Surfaces;
	case 'VrhelDupontPaintChips'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = VrhelDupontPaintChips;
	case 'VrhelMunsellChips'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = VrhelMunsellChips;
	case 'VrhelNaturalObjects'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = VrhelNaturalObjects;
	case 'All'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = [ VrhelNaturalObjects; VrhelMunsellChips; VrhelDupontPaintChips; ...
						ColorChecker; Krinov; Surfaces];
	case 'Vrhel'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = [ VrhelNaturalObjects; VrhelMunsellChips; VrhelDupontPaintChips];
	case 'AllMinusKrinov'
		load( 'Spectra/SpectralDataSet.mat');
		mySpectra = [ VrhelNaturalObjects; VrhelMunsellChips; VrhelDupontPaintChips; ...
						ColorChecker; Surfaces];
	otherwise
		myI1Data = getI1MeasurementData( theSpectraName);
		[ theSpectra, RGBData] = getAllData( myI1Data);
		if nargout == 2
			myCamControl.fUseRGBfromMeasurement = 1;
			theRGB = getCamRGBfromTestchart( theSpectraName, myCamControl);
		end
		return;
end
		
%Interpolation bei den Wellenlängen:
myNumSpectra = size( mySpectra, 1);

mySourceWLVector = (380:4:780)';
myDestWLVector = theWavelengthVector( :);

theSpectra = zeros( myNumSpectra, size( myDestWLVector, 1));
for i = 1:myNumSpectra
	mySpectrumInterp = interp1( mySourceWLVector( :), mySpectra( i, :)', myDestWLVector, 'linear');
	theSpectra( i, :) = mySpectrumInterp( :);
end

if nargout == 2
	theRGB = 0;
end
