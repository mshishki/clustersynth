function theDispImage = displayLuminance( LabImage, theControl)

LImage = (LabImage( :, :, 1) - theControl.Display.RGBLin2LogLab.DOffset) / ...
				theControl.Display.Gamma;

theDispImage = uint8( LabImage);
theDispImage( :, :, 1) = im2uint8( 10.^ LImage);
theDispImage( :, :, 2) = theDispImage( :, :, 1);
theDispImage( :, :, 3) = theDispImage( :, :, 1);
