function theRGB8Image = applyMap( theImage, theMap)

%if size( theImage, 3) == 3
	theRGB8Image = im2uint8( ind2rgb( im2uint8( theImage( :, :, 1)), theMap));


% if size( theImage, 3) == 3
% 	theMapImage( :, :, 1) = theMap.R( theImage( :, :, 1) +1); 
% 	theMapImage( :, :, 2) = theMap.G( theImage( :, :, 2) +1); 
% 	theMapImage( :, :, 3) = theMap.B( theImage( :, :, 3) +1); 
% else
% 	theMapImage( :, :, 1) = theMap.R( theImage( :, :, 1) +1); 
% 	theMapImage( :, :, 2) = theMap.G( theImage( :, :, 1) +1); 
% 	theMapImage( :, :, 3) = theMap.B( theImage( :, :, 1) +1); 
% end
