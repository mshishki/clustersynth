function theInvDisplayModel = invertDisplayModel( theDisplayModel)
uint16Max = 2^16-1;

myGamma = 2.2;

%Korrekturmodell aufsetzen:
theInvDisplayModel.BlackPoint = theDisplayModel.BlackPoint;
theInvDisplayModel.WhitePoint = theDisplayModel.WhitePoint;
theInvDisplayModel.XYZ2RGBMatrix = inv( theDisplayModel.RGB2XYZMatrix);
theInvDisplayModel.Lut.R = ( (invertLUT_double( theDisplayModel.Lut.R.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);
theInvDisplayModel.Lut.G = ( (invertLUT_double( theDisplayModel.Lut.G.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);
theInvDisplayModel.Lut.B = ( (invertLUT_double( theDisplayModel.Lut.B.^(1/myGamma) * uint16Max) - 1)/uint16Max) .^(1/myGamma);

myInvLuts = [theInvDisplayModel.Lut.R', theInvDisplayModel.Lut.G', theInvDisplayModel.Lut.B'];
plot1D3( myInvLuts);

