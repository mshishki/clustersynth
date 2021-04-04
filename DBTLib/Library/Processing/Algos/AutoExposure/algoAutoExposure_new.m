function theAlgoAutoExposure = algoAutoExposure_new()
%Input: 

theAlgoAutoExposure = algo_new( 'AutoExposure');

theAlgoAutoExposure.FuncPtr.getSettings = @algoAutoExposure_getSettings;
theAlgoAutoExposure.FuncPtr.getInputTypeList = @algoAutoExposure_getInputTypeList;
theAlgoAutoExposure.FuncPtr.execute = @algoAutoExposure_execute;



function theAutoExposureSettings = algoAutoExposure_getSettings( theAlgoControl)

theAutoExposureSettings.Settings = theAlgoControl.AutoExposure;



function theInputTypeList = algoAutoExposure_getInputTypeList()

theInputTypeList( 1) = {[{ 'Log_L'}, { 'Log_RGB'}]};



function theAlgoAutoExposureOut = algoAutoExposure_execute( theAlgoAutoExposureIn, theSettings, theInput)
theAlgoAutoExposureOut = theAlgoAutoExposureIn;

%Bildobjekt ist Input
ImageObject = theInput.Input( 1).Input;
myImage = ImageObject.Data.ImageData;
if( isType( ImageObject.Type, 'Log_L'))
    myType = 'Log_L';
else
    myType = 'Log_RGB';
end

%Mittelwerte der Kanäle bestimmen und von Originalbild abziehen
myNumOfChan = size( myImage, 3);
for i=1:myNumOfChan
    myMean = mean2( myImage( : , :, i));
    myImage( : , :, i) = myImage( : , :, i) - myMean + theSettings.Settings.Delta_L;
end

%Datenübergabe
theAlgoAutoExposureOut.Data.Output.Output( 1).Output = new( 'dataImage', { myImage, myType, getTaskName( theAlgoAutoExposureOut)});
