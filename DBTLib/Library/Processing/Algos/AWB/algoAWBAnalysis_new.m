function theAlgoAWBAnalysis = algoAWBAnalysis_new()
%Input: 

theAlgoAWBAnalysis = algo_new( 'AWBAnalysis');

theAlgoAWBAnalysis.FuncPtr.getSettings = @algoAWBAnalysis_getSettings;
theAlgoAWB.FuncPtr.controldialog = @algoAWBAnalysis_controldialog;

theAlgoAWBAnalysis.FuncPtr.getInputTypeList = @algoAWBAnalysis_getInputTypeList;
theAlgoAWBAnalysis.FuncPtr.execute = @algoAWBAnalysis_execute;



function theAWBAnalysisSettings = algoAWBAnalysis_getSettings( theAlgoControl)

theAWBAnalysisSettings.Settings.AWBAnalysis = theAlgoControl.AWBAnalysis;
theAWBAnalysisSettings.Settings.RGBLin2LogLab = theAlgoControl.RGBLin2LogLab;



function theFigureHandle = algoAWBAnalysis_controldialog( theTaskHandle)

theFigureHandle = imAWBEditor( theTaskHandle, getSettings( theTaskHandle), 1, 1);	% 1: Update Images, 1: Close on OKButton



function theInputTypeList = algoAWBAnalysis_getInputTypeList()

theInputTypeList( 1) = {[{ 'Lin_RGB'}]};



function theAlgoAWBAnalysisOut = algoAWBAnalysis_execute( theAlgoAWBAnalysisIn, theSettings, theInput)
theAlgoAWBAnalysisOut = theAlgoAWBAnalysisIn;

%Bildobjekt ist Input
ImageObject = theInput.Input( 1).Input;
myImage = ImageObject.Data.ImageData;

%Übersteuerungsschwelle:
myThreshold = theSettings.Settings.AWBAnalysis.ValidityThreshold;

myDoubleImage = im2double( myImage);
myValidImage = (myDoubleImage( :, :, 1)<myThreshold) | (myDoubleImage( :, :, 2)<myThreshold) | (myDoubleImage( :, :, 3)<myThreshold);

myLinMean( 1) = sum( sum( myDoubleImage( :, :, 1).*myValidImage)) / sum( myValidImage( :));
myLinMean( 2) = sum( sum( myDoubleImage( :, :, 2).*myValidImage)) / sum( myValidImage( :));
myLinMean( 3) = sum( sum( myDoubleImage( :, :, 3).*myValidImage)) / sum( myValidImage( :));

%In Lab wandeln
myMatrix = theSettings.Settings.RGBLin2LogLab.Matrix;
myLogRGBMean = log10( max( myLinMean, 10^-12));
myLogLabMean = myMatrix * myLogRGBMean';
myLog_ab = [ myLogLabMean( 2), myLogLabMean( 3)];

%Delta_ab interaktive Korrektur:
myDelta_ab = [ theSettings.Settings.AWBAnalysis.Delta_a, theSettings.Settings.AWBAnalysis.Delta_b]; 

%Korrekturwerte als Array übergeben
myOutputObj = new( 'dataArray', { myLog_ab + myDelta_ab, 'AWBControl', getTaskName( theAlgoAWBAnalysisOut)});
theAlgoAWBAnalysisOut.Data.Output.Output( 1).Output = myOutputObj;
