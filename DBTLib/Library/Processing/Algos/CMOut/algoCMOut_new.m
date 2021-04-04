function theAlgoCMOut = algoCMOut_new()
%Input: 

theAlgoCMOut = algo_new( 'CMOut');

theAlgoCMOut.FuncPtr.getSettings = @algoCMOut_getSettings;
theAlgoCMOut.FuncPtr.getInputTypeList = @algoCMOut_getInputTypeList;
theAlgoCMOut.FuncPtr.execute = @algoCMOut_execute;



function theCMOutSettings = algoCMOut_getSettings( theAlgoControl)

theCMOutSettings.Settings.IProf = theAlgoControl.CM.ICCInProfile;
theCMOutSettings.Settings.OProf = theAlgoControl.CM.Profiles.sRGB;



function theInputTypeList = algoCMOut_getInputTypeList()

theInputTypeList( 1) = {[{ 'Image'}]};



function theAlgoCMOutOut = algoCMOut_execute( theAlgoCMOutIn, theSettings, theInput)
theAlgoCMOutOut = theAlgoCMOutIn;

ImageObject = theInput.Input( 1).Input;
theAlgoCMOutOut.Data.Output.Output( 1).Output = ImageObject;
% ImageObject = theInput.Input( 1);
% theAlgoCMOutOut.Data.Output.Output( 1) = ImageObject;

%Bildberechnung
CMImage = imColorTransform( ImageObject.Data.ImageData, theSettings.Settings.IProf, theSettings.Settings.OProf);

%theAlgoCMOutOut.Data.Output.Output( 1) = new( 'dataImage', {CMImage, 'sRGB', getTaskName( theAlgoCMOutOut)});

theAlgoCMOutOut.Data.Output.Output( 1).Output = new( 'dataImage', {CMImage, 'sRGB', getTaskName( theAlgoCMOutOut)});
% %Nur zum Test
% theAlgoCMOutOut.Data.Output.Output( 2).Output = ones( 1000);

% theAlgoCMOutOut.Data.Output.Output( 1).Type = 'Image_sRGB';
% theAlgoCMOutOut.Data.Output.Output( 1).Data.ImageData = CMImage;
% theAlgoCMOutOut.Data.Output.Output( 1).Data.ImageType = 'sRGB';
% theAlgoCMOutOut.Data.Output.Output( 1).Data.FileName = '';
 