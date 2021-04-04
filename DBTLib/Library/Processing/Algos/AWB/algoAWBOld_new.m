function theAlgoAWB = algoAWB_new()
%Input: 

theAlgoAWB = algo_new( 'AWB');

theAlgoAWB.FuncPtr.getSettings = @algoAWB_getSettings;
theAlgoAWB.FuncPtr.getInputTypeList = @algoAWB_getInputTypeList;
theAlgoAWB.FuncPtr.execute = @algoAWB_execute;



function theAWBSettings = algoAWB_getSettings( theAlgoControl)

theAWBSettings.Settings.IProf = theAlgoControl.CM.ICCInProfile;
theAWBSettings.Settings.OProf = theAlgoControl.Display.ICCProfile;



function theInputTypeList = algoAWB_getInputTypeList()

theInputTypeList( 1) = {[{ 'Image'}]};



function theAlgoAWBOut = algoAWB_execute( theAlgoAWBIn, theSettings, theInput)
theAlgoAWBOut = theAlgoAWBIn;

ImageObject = theInput.Input( 1).Input;
theAlgoAWBOut.Data.Output.Output( 1).Output = ImageObject;
% ImageObject = theInput.Input( 1);
% theAlgoAWBOut.Data.Output.Output( 1) = ImageObject;

%Bildberechnung
CMImage = imColorTransform( ImageObject.Data.ImageData, theSettings.Settings.IProf, theSettings.Settings.OProf);

%theAlgoAWBOut.Data.Output.Output( 1) = new( 'dataImage', {CMImage, 'sRGB', getTaskName( theAlgoAWBOut)});

theAlgoAWBOut.Data.Output.Output( 1).Output = new( 'dataImage', {CMImage, 'sRGB', getTaskName( theAlgoAWBOut)});
% %Nur zum Test
% theAlgoAWBOut.Data.Output.Output( 2).Output = ones( 1000);

% theAlgoAWBOut.Data.Output.Output( 1).Type = 'Image_sRGB';
% theAlgoAWBOut.Data.Output.Output( 1).Data.ImageData = CMImage;
% theAlgoAWBOut.Data.Output.Output( 1).Data.ImageType = 'sRGB';
% theAlgoAWBOut.Data.Output.Output( 1).Data.FileName = '';
 



%Dichtewandlung
myLogOffset = 10^-9;    %nur zum Abfangen von 0-Werten ohne sichtbare Veränderung
myDensityImage =log10( im2double( myDemosaickedImage) + myLogOffset);

% %Test:
% myDensityImage( :, :, :) = 0;

%automatischer Grauabgleich und Helligkeitsabgleich
myNormalizedImage = normalizeImage( myDensityImage, myControl.WB.DeltaD);
%automatischer Grauabgleich
%myNormalizedImage = normalizeImage( myDensityImage, myControl.DeltaD-mean( myControl.WB.DeltaD));


% Gradation + Offset
myDrgbImage(:,:,1) = myNormalizedImage(:,:,1).* myControl.GradationOffset.RGBGradation;
myDrgbImage(:,:,2) = myNormalizedImage(:,:,2).* myControl.GradationOffset.RGBGradation;
myDrgbImage(:,:,3) = myNormalizedImage(:,:,3).* myControl.GradationOffset.RGBGradation; 

% Offset
myDrgbImage = myDrgbImage - myControl.GradationOffset.Offset;
%Offset und Helligkeitsabgleich
%myDrgbImage = myDrgbImage - mean( myControl.WB.DeltaD) - myControl.GradationOffset.Offset;

% Lineare RGB 
myLinImage = 10.^myDrgbImage;



function theNormalizedImage = normalizeImage( theDensityImage, theDeltaD)

%myMean = mean( mean( theDensityImage));
myMean = log10( mean( mean( 10.^theDensityImage)));

theNormalizedImage( :, :, 1) = theDensityImage( :, :, 1) - myMean(1) - theDeltaD( 1);
theNormalizedImage( :, :, 2) = theDensityImage( :, :, 2) - myMean(2) - theDeltaD( 2);
theNormalizedImage( :, :, 3) = theDensityImage( :, :, 3) - myMean(3) - theDeltaD( 3);

end %normalizeImage