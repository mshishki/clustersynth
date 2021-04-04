function theControl = initializeControlTCAnalysis( theMaxValue)

% Einstellungen für die Displayanzeige
theControl.Display.Gamma = 2.2;				

% Zahlentyp
theControl.Testchart.MaxValue = theMaxValue;				

% Anzahl der Patches in X- und Y-Richtung
theControl.Testchart.NumX = 14;				
theControl.Testchart.NumY = 10;				

% Gültige Ausdehnung bezogen auf den Abstand zwischen 2 Patches
theControl.Testchart.RelPatchSizeX = 0.4;	
theControl.Testchart.RelPatchSizeY = 0.4;
theControl.Testchart.MinPatchSizeX = 7;	
theControl.Testchart.MinPatchSizeY = 7;

%Zentrierung der Marker:
theControl.Testchart.CenterOn = 0;	%0: ohne Zentrierung, 1: mit
% rel. Schwellwert:
theControl.Testchart.CenterThreshold = 0.7;	
