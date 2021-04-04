function the_xy = uv2xy( the_uv)
my_u = the_uv(:,:,1);
my_v = the_uv(:,:,2);

my_x = 9*my_u ./ (6*my_u - 16*my_v + 12);
my_y = 4*my_v ./ (6*my_u - 16*my_v + 12);

the_xy = my_x;
the_xy( :, :, 2) = my_y;