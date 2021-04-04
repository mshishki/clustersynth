function theSS_Norm = normalizeSpectralSensitivities( theSpectralSensitivities_Ref, theSpectralSensitivities, ...
										theParams4SpectralSensiCompare)
myNormIlluminant = theParams4SpectralSensiCompare.Illuminant_Norm;

%Initialisierung
theSS_Norm = theSpectralSensitivities;

myRGBRefCamWP = simRGBfromSpectralFlux( myNormIlluminant', theSpectralSensitivities_Ref);
myRGBCamWP = simRGBfromSpectralFlux( myNormIlluminant', theSpectralSensitivities);

switch theParams4SpectralSensiCompare.NormMethod
	case 'intensity'
		myNormFactor = sum( myRGBRefCamWP(:)) / sum( myRGBCamWP(:));
		for i=1:3
			theSS_Norm( :, i) = theSpectralSensitivities( :, i) * myNormFactor;
		end		
	case 'relative'
		for i=1:3
			theSS_Norm( :, i) = theSpectralSensitivities( :, i) * myRGBRefCamWP( i) / myRGBCamWP( i);
		end		
	otherwise
end
		