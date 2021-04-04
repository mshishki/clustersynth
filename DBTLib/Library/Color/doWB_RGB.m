function theRGB_WB = doWB_RGB( theRGB, theRGB_WP)
%Usage: theRGB_WB = doWB_RGB( theRGB, theRGB_WP);

R = theRGB( :, 1)/theRGB_WP( 1);
G = theRGB( :, 2)/theRGB_WP( 2);
B = theRGB( :, 3)/theRGB_WP( 3);

theRGB_WB = [R, G, B];