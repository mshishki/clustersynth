function bal_bayer=whitebalanceBayer(theImage,wb_multipliers,thePattern)

%Normierung
wb_multipliers = wb_multipliers / wb_multipliers( 2);

if strcmp( thePattern, 'rggb')
	theImage( 1:2:end, 1:2:end) = theImage( 1:2:end, 1:2:end) * wb_multipliers( 1);
	theImage( 1:2:end, 2:2:end) = theImage( 1:2:end, 2:2:end) * wb_multipliers( 2);
	theImage( 2:2:end, 1:2:end) = theImage( 2:2:end, 1:2:end) * wb_multipliers( 2);
	theImage( 2:2:end, 2:2:end) = theImage( 2:2:end, 2:2:end) * wb_multipliers( 3);
elseif strcmp( thePattern, 'grbg')
	theImage( 1:2:end, 1:2:end) = theImage( 1:2:end, 1:2:end) * wb_multipliers( 2);
	theImage( 1:2:end, 2:2:end) = theImage( 1:2:end, 2:2:end) * wb_multipliers( 1);
	theImage( 2:2:end, 1:2:end) = theImage( 2:2:end, 1:2:end) * wb_multipliers( 3);
	theImage( 2:2:end, 2:2:end) = theImage( 2:2:end, 2:2:end) * wb_multipliers( 2);
elseif strcmp( thePattern, 'gbrg')
	theImage( 1:2:end, 1:2:end) = theImage( 1:2:end, 1:2:end) * wb_multipliers( 2);
	theImage( 1:2:end, 2:2:end) = theImage( 1:2:end, 2:2:end) * wb_multipliers( 3);
	theImage( 2:2:end, 1:2:end) = theImage( 2:2:end, 1:2:end) * wb_multipliers( 1);
	theImage( 2:2:end, 2:2:end) = theImage( 2:2:end, 2:2:end) * wb_multipliers( 2);
elseif strcmp( thePattern, 'bggr')
	theImage( 1:2:end, 1:2:end) = theImage( 1:2:end, 1:2:end) * wb_multipliers( 3);
	theImage( 1:2:end, 2:2:end) = theImage( 1:2:end, 2:2:end) * wb_multipliers( 2);
	theImage( 2:2:end, 1:2:end) = theImage( 2:2:end, 1:2:end) * wb_multipliers( 2);
	theImage( 2:2:end, 2:2:end) = theImage( 2:2:end, 2:2:end) * wb_multipliers( 1);
end 

bal_bayer = theImage;