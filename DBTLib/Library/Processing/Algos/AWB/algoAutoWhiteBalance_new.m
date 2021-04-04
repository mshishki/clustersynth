function theAlgoAWB = algoAutoWhiteBalance_new()
%Input: 

theAlgoAWB = algo_new( 'AWB');

theAlgoAWB.FuncPtr.getSettings = @algoAWB_getSettings;
theAlgoAWB.FuncPtr.controldialog = @algoAWB_controldialog;

theAlgoAWB.FuncPtr.getInputTypeList = @algoAWB_getInputTypeList;
theAlgoAWB.FuncPtr.execute = @algoAWB_execute;



function theAWBSettings = algoAWB_getSettings( theAlgoControl)

theAWBSettings.Settings = theAlgoControl.AWB;



function theFigureHandle = algoAWB_controldialog( theTaskHandle)

theFigureHandle = imAWBEditor( theTaskHandle, getSettings( theTaskHandle), 1, 1);	% 1: Update Images on, 1: Close on OKButton



function theInputTypeList = algoAWB_getInputTypeList()

theInputTypeList( 1) = {[{ 'Log_ab'}]};
theInputTypeList( 2) = {[{ 'AWBControl'}]};



function theAlgoAWBOut = algoAWB_execute( theAlgoAWBIn, theSettings, theInput)
theAlgoAWBOut = theAlgoAWBIn;

%Bildobjekt ist Input
ImageObject = theInput.Input( 1).Input;
myImage = ImageObject.Data.ImageData;
if( isType( ImageObject.Type, 'Log_ab'))
    myType = 'Log_ab';
else
    myType = 'Log_ab';
end

%Korrekturwerte der AWB Analyse (vorher)
ArrayObject = theInput.Input( 2).Input;
Log_ab_AWB = ArrayObject.Data.ArrayData;

%Delta_ab interaktive Korrektur:
myDelta_ab = [ theSettings.Settings.Delta_a, theSettings.Settings.Delta_b]; 

%Korrekturwerte von Originalbild abziehen
myImage( : , :, 1) = myImage( : , :, 1) - Log_ab_AWB( 1) + myDelta_ab( 1);
myImage( : , :, 2) = myImage( : , :, 2) - Log_ab_AWB( 2) + myDelta_ab( 2);

%Datenübergabe
theAlgoAWBOut.Data.Output.Output( 1).Output = new( 'dataImage', { myImage, myType, getTaskName( theAlgoAWBOut)});


