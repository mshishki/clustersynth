function theDispImage = displayChrominance( LabImage, theDisplayControl)

disp_ab = LabImage * theDisplayControl.abFactor;
disp_ab( :, :, 1) = 0;
disp_DrgbImage = imMatMul( im2double( disp_ab), theDisplayControl.RGBLin2LogLab.invMatrix) - theDisplayControl.RGBLin2LogLab.DOffset;
disp_RGBLinImage = 10.^( disp_DrgbImage+0.2);%um D=0.2 heller
theDispImage = im2uint8( imColorTransform( disp_RGBLinImage, ...
	theDisplayControl.RGBLinProfile, theDisplayControl.DispProfile));

if 0
	%imdisplay( disp_RGBImage);
	myR = LabImage( :, :, 2)+0.5;
	myA = LabImage( :, :, 2);
	myR( (myA>(-0.01)) & (myA<0.01)) = 255;
	imdisplay( myR);

	myR = LabImage( :, :, 2)+0.5;
	myB = LabImage( :, :, 3);
	myR( (myB>(-0.01)) & (myB<+0.01)) = 255;
	imdisplay( myR);
end

% RGBLinImageDouble = double( RGBLinImage);
% RGBLinSum = RGBLinImageDouble( :, :, 1) + RGBLinImageDouble( :, :, 2) + RGBLinImageDouble( :, :, 3);
% rgbImage( :, :, 1) = RGBLinImageDouble( :, :, 1) ./ RGBLinSum;
% rgbImage( :, :, 2) = RGBLinImageDouble( :, :, 2) ./ RGBLinSum;
% rgbImage( :, :, 3) = RGBLinImageDouble( :, :, 3) ./ RGBLinSum;
% %imdisplay( rgbImage, 2.2);

