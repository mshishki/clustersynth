function [ theSpectralData, theRGB] = getAllData( theMeasurementData)
%Usage: [ theSpectralData, theRGB] = getAllData( theMeasurementData);
%Hint: theMeasurementData come from getI1MeasurementData()

theSpectralData = cell2mat( theMeasurementData.Patches( 1, 6:end));
theRGB = cell2mat( theMeasurementData.Patches( 1, 3:5));

end %