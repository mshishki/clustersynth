function theRGB = Lab2RGB( theLab, theControl)

disp_DrgbImage = imMatMul( theLab, theControl.RGBLin2LogLab.invMatrix) - theControl.RGBLin2LogLab.DOffset;
disp_RGBLinImage = 10.^( disp_DrgbImage);
theRGB = imColorTransform( im2uint16( disp_RGBLinImage), ...
	theControl.Display.RGBLinProfile, theControl.Display.DispProfile);

