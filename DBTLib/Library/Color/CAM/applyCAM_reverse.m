function theXYZCAM = applyCAM_reverse( theCAA, theCAMControl)

myRGB_a_W = computeRGB_a_forward( theCAMControl.XYZ_W, theCAMControl.RGBParams);

myRGB_a = computeCAA_reverse( theCAA, myRGB_a_W, theCAMControl.CAParams);

theXYZCAM = computeRGB_a_reverse( myRGB_a, theCAMControl.RGBParams);


