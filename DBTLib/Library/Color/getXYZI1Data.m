function theI1XYZ = getXYZI1Data( theInProf, theF_XYZ_RGB);

theXYZProf = 'LCMSXYZI.ICM';

i1MeasurementData = getI1MeasurementData();

[ SpectralData, RGBData] = getAllData( i1MeasurementData);

%Spektraldaten in XYZ-Werte umrechnen:
XYZCurves_5nm = load( 'XYZ2_5nm_380_735.mat');
XYZCurves_10nm = XYZCurves_5nm.XYZ10_5nm_380_735( 1:2:end, :)/10^4;

D50 = load( 'D50.mat');
D50 = D50.D50;
Yw = D50'*XYZCurves_10nm( :, 2);

SpectralFlux = SpectralData;
for i=1:i1MeasurementData.NrOfPatches
    SpectralFlux( i, :) = SpectralData( i, :) .* D50';
end

theI1XYZ = (SpectralFlux * XYZCurves_10nm)*100/Yw;

end %getXYZI1Data()