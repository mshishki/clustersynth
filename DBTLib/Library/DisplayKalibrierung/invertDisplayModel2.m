function theInvDisplayModel = invertDisplayModel2( theDisplayModel)
uint16Max = 2^16-1;

myGamma = 2.2;

%Korrekturmodell aufsetzen:
theInvDisplayModel.BlackPoint = theDisplayModel.BlackPoint;
theInvDisplayModel.WhitePoint = theDisplayModel.WhitePoint;
theInvDisplayModel.Luminance = theDisplayModel.Luminance;
theInvDisplayModel.XYZ2RGBMatrix = inv( theDisplayModel.RGB2XYZMatrix);

%Kennlinien invertieren mit Gamma-Vorverzerrung:
myX = (0:uint16Max) / uint16Max;
LutRLin = interp1( myX.^(myGamma), theDisplayModel.Lut.R, myX);
theInvDisplayModel.Lut.R = ( (invertLUT_double( LutRLin * uint16Max) - 1)/uint16Max) .^(1/myGamma);
LutGLin = interp1( myX.^(myGamma), theDisplayModel.Lut.G, myX);
theInvDisplayModel.Lut.G = ( (invertLUT_double( LutGLin * uint16Max) - 1)/uint16Max) .^(1/myGamma);
LutBLin = interp1( myX.^(myGamma), theDisplayModel.Lut.B, myX);
theInvDisplayModel.Lut.B = ( (invertLUT_double( LutBLin * uint16Max) - 1)/uint16Max) .^(1/myGamma);
% %falsch: Gamma-Verzerrung erst nach der LUT
% theInvDisplayModel.Lut.R = ( (invertLUT_double( theDisplayModel.Lut.R.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);
% theInvDisplayModel.Lut.G = ( (invertLUT_double( theDisplayModel.Lut.G.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);
% theInvDisplayModel.Lut.B = ( (invertLUT_double( theDisplayModel.Lut.B.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);
theInvDisplayModel.RGBLinBP = theDisplayModel.RGBLinBP;

myInvLuts = [theInvDisplayModel.Lut.R', theInvDisplayModel.Lut.G', theInvDisplayModel.Lut.B'];
plot1D3( myInvLuts);

