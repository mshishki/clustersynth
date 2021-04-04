function theDisplayModel = getDisplayModel2( theXYZ_Black, theXYZ_White, theLumiWhiteXYZ, theRGB2XYZMatrix, theLutR, theLutG, theLutB, theRGBLinBP)

theDisplayModel.Forward.BlackPoint = theXYZ_Black;
theDisplayModel.Forward.WhitePoint = theXYZ_White;
theDisplayModel.Forward.Luminance = theLumiWhiteXYZ;
theDisplayModel.Forward.RGB2XYZMatrix = theRGB2XYZMatrix;
theDisplayModel.Forward.Lut.R = theLutR;
theDisplayModel.Forward.Lut.G = theLutG;
theDisplayModel.Forward.Lut.B = theLutB;
theDisplayModel.Forward.RGBLinBP = theRGBLinBP;

theDisplayModel.Backward = invertDisplayModel2( theDisplayModel.Forward);
