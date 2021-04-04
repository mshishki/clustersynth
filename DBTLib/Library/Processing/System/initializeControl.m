function theControl = initializeControl( theAlgoList)

if( nargin > 0)
    theControl.Algo.AlgoList = theAlgoList;
end

%Agfa Lab Trafo:
x = (1:2^16)/(2^16);
myLabTrafo.LogLut = log10( x);
myLabTrafo.Matrix = [ 1, 1, 1; 0.5, -.5, 0; 0.25, 0.25, -0.5];
myLabTrafo.invMatrix = inv( myLabTrafo.Matrix);
myLabTrafo.DOffset = 0.7;


myRawSettings = getRawSettings();

theControl.Display.Fill3Channels = true;
theControl.Display.Raw = getRaw2DisplaySettings( myRawSettings);
theControl.Display.Gamma = 2.0;
theControl.Display.RGBLin2LogLab = myLabTrafo;
theControl.Display.RGBLin2LogLab.DOffset = -0.5; %Helligkeitskorrektur für die Lab-Darstellung

theControl.Algo.Sensor = myRawSettings.Sensor;

theControl.Algo.Demosaicking.AlgoType = 'fast'; %'bilinear'; 'POCS'; 'fast';

theControl.Algo.Resize = initResize();

theControl.Algo.AWBAnalysis.ValidityThreshold = 0.97;   %übersteuerte Regionen werden ausmaskiert
theControl.Algo.AWBAnalysis.Delta_a = 0;
theControl.Algo.AWBAnalysis.Delta_b = 0;
theControl.Algo.AWBAnalysis.RGBLin2LogLab = myLabTrafo;
theControl.Algo.AWB.Delta_a = 0;
theControl.Algo.AWB.Delta_b = 0;
theControl.Algo.AWB.RGBLin2LogLab = myLabTrafo;
theControl.Algo.AutoExposure.Delta_L = 0;


theControl.Algo.RGBLin2LogLab = myLabTrafo;
    
%theControl.Algo.Display.ICCProfile = 'Lib/ICCProfiles/sRGB.icm';
theControl.Algo.Display.ICCProfile = 'Lib/ICCProfiles/LCDDellE6500_05.01.2009_2.icc';

theControl.Algo.CM.ICCInProfile = 'Lib/ICCProfiles/S3OhneReflexEigeneReferenz.icc';
theControl.Algo.CM.Profiles.sRGB = 'Lib/ICCProfiles/sRGB.icm';
theControl.Algo.CM.Profiles.sRGBLinear = 'Lib/ICCProfiles/sRGBLinear.icc';
theControl.Algo.CM.Profiles.RGB = 'Lib/ICCProfiles/sRGB.icm';   %default für unbek. RGB
theControl.Algo.CM.Profiles.RGBLinear = 'Lib/ICCProfiles/sRGBLinear.icc';
theControl.Algo.CM.Profiles.AdobeRGB = 'Lib/ICCProfiles/AdobeRGB.icc';
theControl.Algo.CM.Profiles.AdobeRGBLinear = 'Lib/ICCProfiles/AdobeRGBLinear.icc';



