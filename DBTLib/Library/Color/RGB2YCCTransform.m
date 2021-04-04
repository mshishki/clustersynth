function theYCC = RGB2YCCTransform( theRGB)
RGB2YCC = [ 77, 150, 29; -43, -85, 128; 128, -107, -21]/256;

% 	RGB2YCCComp = [ 0.299, 0.587, 0.114; -0.169, -0.331, 0.5; 0.5, -0.419, -0.081];
% 	TotMat = YCC2RGB*RGB2YCCComp
% 	TotMat * [ 255 0, 0]'
% 	TotMat * [ 0, 255, 0]'
% 	TotMat * [ 0, 0, 255]'
% 	TotMat * [ 255, 255, 255]'

theYCC = imMatMul_Single( theRGB, RGB2YCC);
