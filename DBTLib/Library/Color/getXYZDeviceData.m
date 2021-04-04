function [the_XYZ_Device] = getXYZDeviceData( theInProf);

theXYZProf = 'LCMSXYZI.ICM';

i1MeasurementData = getI1MeasurementData();

[ SpectralData, RGBData] = getAllData( i1MeasurementData);

%RGB in XYZ umrechnen:

myRGBImage = zeros( 1, i1MeasurementData.NrOfPatches, 3);
myRGBImage( 1, :, 1) = RGBData( :, 1)/255;
myRGBImage( 1, :, 2) = RGBData( :, 2)/255;
myRGBImage( 1, :, 3) = RGBData( :, 3)/255;

myXYZImage = softProof( myRGBImage, theInProf, theXYZProf);

XYZData = RGBData;
XYZData( :, 1) = myXYZImage( 1, :, 1);
XYZData( :, 2) = myXYZImage( 1, :, 2);
XYZData( :, 3) = myXYZImage( 1, :, 3);

the_XYZ_Device = XYZData;

end %getXYZDeviceData()