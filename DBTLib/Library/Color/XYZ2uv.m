function the_uv = XYZ2uv( theXYZ)

my_x = theXYZ( :, 1) ./ sum( theXYZ, 2);
my_y = theXYZ( :, 2) ./ sum( theXYZ, 2);

my_u = 4*my_x ./ (-2*my_x + 12*my_y + 3);
my_v = 9*my_y ./ (-2*my_x + 12*my_y + 3);

the_uv = [ my_u, my_v];