function 	theLab = RGB2Lab( theRGB, theControl)
	
RGBLinImage = imColorTransform( im2uint16( theRGB), theControl.CM.Profiles.RGB, theControl.CM.Profiles.RGBLinear);

DrgbImage = theControl.RGBLin2LogLab.LogLut( im2uint16( RGBLinImage) + 1) + theControl.RGBLin2LogLab.DOffset;
theLab = imMatMul( DrgbImage, theControl.RGBLin2LogLab.Matrix);
