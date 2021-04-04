function theAlgoRGBLin2LogLab = algoRGBLin2LogLab_new()
%Input: 

theAlgoRGBLin2LogLab = algo_new( 'RGBLin2LogLab');

theAlgoRGBLin2LogLab.FuncPtr.getSettings = @algoRGBLin2LogLab_getSettings;
theAlgoRGBLin2LogLab.FuncPtr.getInputTypeList = @algoRGBLin2LogLab_getInputTypeList;
theAlgoRGBLin2LogLab.FuncPtr.execute = @algoRGBLin2LogLab_execute;



function theRGBLin2LogLabSettings = algoRGBLin2LogLab_getSettings( theAlgoControl)

theRGBLin2LogLabSettings.Settings.RGBLin2LogLab = theAlgoControl.RGBLin2LogLab;



function theInputTypeList = algoRGBLin2LogLab_getInputTypeList()

theInputTypeList( 1) = {[{ 'Lin_RGB'}]};



function theAlgoRGBLin2LogLabOut = algoRGBLin2LogLab_execute( theAlgoRGBLin2LogLabIn, theSettings, theInput)
theAlgoRGBLin2LogLabOut = theAlgoRGBLin2LogLabIn;

ImageObject = theInput.Input( 1).Input;

%Bildberechnung
DrgbImage = theSettings.Settings.RGBLin2LogLab.LogLut( im2uint16( ImageObject.Data.ImageData) + 1) + theSettings.Settings.RGBLin2LogLab.DOffset;
LabImage = imMatMul( DrgbImage, theSettings.Settings.RGBLin2LogLab.Matrix);
theAlgoRGBLin2LogLabOut.Data.Output.Output( 1).Output = new( 'dataImage', { LabImage, 'Log_Lab', getTaskName( theAlgoRGBLin2LogLabOut)});



