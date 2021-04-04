function theRGBCorr = applyFlareCorrection( theRGB, theFlareInfo)

if( isfloat( theRGB))
	theRGBCorr( :, 1) = theRGB( :, 1) * theFlareInfo.Slope( 1) + theFlareInfo.Offset( 1);
	theRGBCorr( :, 2) = theRGB( :, 2) * theFlareInfo.Slope( 2) + theFlareInfo.Offset( 2);
	theRGBCorr( :, 3) = theRGB( :, 3) * theFlareInfo.Slope( 3) + theFlareInfo.Offset( 3);
else
	theRGBCorr( :, 1) = theFlareInfo.FlareLuts( uint16( theRGB( :, 1)+1), 1);
	theRGBCorr( :, 2) = theFlareInfo.FlareLuts( uint16( theRGB( :, 2)+1), 2);
	theRGBCorr( :, 3) = theFlareInfo.FlareLuts( uint16( theRGB( :, 3)+1), 3);

%16 Bit Variante
% 	myRGB_FC( :, 1) = myFlareInfo.FlareLuts( uint32( myRGBReal( :, 1)/theRGBMaxValue*(2^16-1)+1), 1);
% 	myRGB_FC( :, 2) = myFlareInfo.FlareLuts( uint32( myRGBReal( :, 2)/theRGBMaxValue*(2^16-1)+1), 2);
% 	myRGB_FC( :, 3) = myFlareInfo.FlareLuts( uint32( myRGBReal( :, 3)/theRGBMaxValue*(2^16-1)+1), 3);
end

