function theAlgoLogLab2RGBLin = algoLogLab2RGBLin_new()
%Input: 

theAlgoLogLab2RGBLin = algo_new( 'LogLab2RGBLin');

theAlgoLogLab2RGBLin.FuncPtr.getSettings = @algoLogLab2RGBLin_getSettings;
theAlgoLogLab2RGBLin.FuncPtr.getInputTypeList = @algoLogLab2RGBLin_getInputTypeList;
theAlgoLogLab2RGBLin.FuncPtr.execute = @algoLogLab2RGBLin_execute;



function theLogLab2RGBLinSettings = algoLogLab2RGBLin_getSettings( theAlgoControl)

theLogLab2RGBLinSettings.Settings.RGBLin2LogLab = theAlgoControl.RGBLin2LogLab;



function theInputTypeList = algoLogLab2RGBLin_getInputTypeList()

theInputTypeList( 1) = {[{ 'Log_Lab'}]};



function theAlgoLogLab2RGBLinOut = algoLogLab2RGBLin_execute( theAlgoLogLab2RGBLinIn, theSettings, theInput)
theAlgoLogLab2RGBLinOut = theAlgoLogLab2RGBLinIn;

LabImageObject = theInput.Input( 1).Input;

%Bildberechnung
DrgbImage = imMatMul( im2double( LabImageObject.Data.ImageData), theSettings.Settings.RGBLin2LogLab.invMatrix) - theSettings.Settings.RGBLin2LogLab.DOffset;
RGBLinImage = 10.^( DrgbImage);
theAlgoLogLab2RGBLinOut.Data.Output.Output( 1).Output = new( 'dataImage', { RGBLinImage, 'Lin_RGB', getTaskName( theAlgoLogLab2RGBLinOut)});



