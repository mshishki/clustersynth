function theAlgoDisplayImage = algoDisplayImage_new()
%Input: 

theAlgoDisplayImage = algo_new( 'DisplayImage');

theAlgoDisplayImage.FuncPtr.getSettings = @algoDisplayImage_getSettings;
theAlgoDisplayImage.FuncPtr.getInputTypeList = @algoDisplayImage_getInputTypeList;
theAlgoDisplayImage.FuncPtr.execute = @algoDisplayImage_execute;



function theDisplayImageSettings = algoDisplayImage_getSettings( theAlgoControl)

theDisplayImageSettings.Settings.CM = theAlgoControl.CM;
theDisplayImageSettings.Settings.OProf = theAlgoControl.Display.ICCProfile;




function theInputTypeList = algoDisplayImage_getInputTypeList()

theInputTypeList( 1) = {[{ 'Image'}]};



function theAlgoDisplayImageOut = algoDisplayImage_execute( theAlgoDisplayImageIn, theSettings, theInput)
theAlgoDisplayImageOut = theAlgoDisplayImageIn;

ImageObject = theInput.Input( 1).Input;
theAlgoDisplayImageOut.Data.Output.Output( 1).Output = ImageObject;
% ImageObject = theInput.Input( 1);
% theAlgoDisplayImageOut.Data.Output.Output( 1) = ImageObject;

IProf = getICCProf( theSettings.Settings.CM.Profiles, ImageObject.Type);
if( isempty( IProf))
    IProf = theSettings.Settings.CM.Profiles.RGB;
end

%Bildberechnung
CMImage = imColorTransform( ImageObject.Data.ImageData, IProf, theSettings.Settings.OProf);

theAlgoDisplayImageOut.Data.Output.Output( 1).Output = new( 'dataImage', { CMImage, 'dispRGB', getTaskName( theAlgoDisplayImageOut)});
% theAlgoDisplayImageOut.Data.Output.Output( 1) = new( 'dataImage', { CMImage, 'sRGB', getTaskName( theAlgoDisplayImageOut)});



    