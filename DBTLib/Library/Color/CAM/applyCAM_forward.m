function theCAA = applyCAM_forward( theXYZOrig, theCAMControl)



myRGB_a = computeRGB_a_forward( theXYZOrig, theCAMControl.RGBParams);
myRGB_a_W = computeRGB_a_forward( theCAMControl.XYZ_W, theCAMControl.RGBParams);


theCAA = computeCAA_forward( myRGB_a, myRGB_a_W, theCAMControl.CAParams);
