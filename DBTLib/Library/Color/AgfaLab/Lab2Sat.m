function SatImage = Lab2Sat( LabImage)

SatImage = sqrt( LabImage( :, :, 2).^2 + LabImage( :, :, 3).^2);
