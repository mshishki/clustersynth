function theDestAdobeRGBLin = applyACR2HDR( theSourceAdobeRGBLin, theExpoCorrection3, theNoiseLevel3)
%Photoshop-Gradationskennlinie auf lineare Adobe RGB anwenden

%ACR Modelldaten einlesen
help = load( 'CMMaestro_Complex.mat');
myACRModel = help.Maestro;

for i=1:size( theSourceAdobeRGBLin, 3)
	if length( theExpoCorrection3)>1
		myExpoCorrection = theExpoCorrection3( i);
	else
		myExpoCorrection = theExpoCorrection3( 1);
	end
	myNormImageAdobeRGBLin( :, :, i) = theSourceAdobeRGBLin( :, :, i) * myExpoCorrection;
end

%Modell anwenden 
myProPhotoRGB = imColorTransform( myNormImageAdobeRGBLin, 'Library/ICCProfiles/AdobeRGBLinear.icc', 'Library/ICCProfiles/ProPhotoLinear.icc');

for i=1:size( theSourceAdobeRGBLin, 3)
	if length( theExpoCorrection3)>1
		myExpoCorrection = theExpoCorrection3( i);
	else
		myExpoCorrection = theExpoCorrection3( 1);
	end
	if length( theNoiseLevel3)>1
		myNoiseLevel = theNoiseLevel3( i);
	else
		myNoiseLevel = theNoiseLevel3( 1);
	end
	myPPRGBNoise( :, :, i) = imnoise( myProPhotoRGB( :, :, i), 'Gaussian', 0, (myNoiseLevel*myExpoCorrection)^2);
end

myProPhotoRGBGrad = applyGradLUT( myPPRGBNoise, myACRModel.RGBCurve, 1, 1, 'RGB');
theDestAdobeRGBLin = imColorTransform( myProPhotoRGBGrad, 'Library/ICCProfiles/ProPhotoLinear.icc', 'Library/ICCProfiles/AdobeRGBLinear.icc');
