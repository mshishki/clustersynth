function theAlgoDemosaic = algoDemosaic_new()
%Input: 

theAlgoDemosaic = algo_new( 'Demosaicking');

theAlgoDemosaic.FuncPtr.getSettings = @algoDemosaic_getSettings;
theAlgoDemosaic.FuncPtr.getInputTypeList = @algoDemosaic_getInputTypeList;
theAlgoDemosaic.FuncPtr.execute = @algoDemosaic_execute;



function theDemosaicSettings = algoDemosaic_getSettings( theAlgoControl)

theDemosaicSettings.Settings.Sensor = theAlgoControl.Sensor;
theDemosaicSettings.Settings.Demosaicking = theAlgoControl.Demosaicking;



function theInputTypeList = algoDemosaic_getInputTypeList()

theInputTypeList( 1) = {[{ 'Raw'}]};



function theAlgoDemosaicOut = algoDemosaic_execute( theAlgoDemosaicIn, theSettings, theInput)
theAlgoDemosaicOut = theAlgoDemosaicIn;

ImageObject = theInput.Input( 1).Input;

%Bildberechnung
DemosaicImage = applyDemosaicking( ImageObject.Data.ImageData, theSettings.Settings.Demosaicking.AlgoType);
DemosaicImageNorm = im2uint16( double( DemosaicImage)./theSettings.Settings.Sensor.Range( 2));
theAlgoDemosaicOut.Data.Output.Output( 1).Output = new( 'dataImage', { DemosaicImageNorm, 'Lin_RGB', getTaskName( theAlgoDemosaicOut)});



