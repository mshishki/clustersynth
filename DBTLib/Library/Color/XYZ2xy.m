function the_xy = XYZ2xy( theXYZ)

the_xy( :, 1) = theXYZ( :, 1) ./ sum( theXYZ, 2);
the_xy( :, 2) = theXYZ( :, 2) ./ sum( theXYZ, 2);
