function theXYZPrint = imXYZMonitor2Print(the_XYZMonitor)
%
% Image-Transformation: Monitor -> Print
%
% Parameter: the_XYZMonitor - Pfad zur Bilddatei
% Aufruf-Beispiel: Monitor2Print('IMG01234.JPG');
%
% Author: Arne Christiansen
% Datum:  10.01.2013 
%

%% Initialisierung

% Farbtemperatur
sourceT = 6500;
destT = 5000;

% XYZ-Weißpunkte
myXYZSource_W = getXYZWhite( getT( sourceT));
myXYZDest_W = getXYZWhite( getT( destT));

%Leuchtdichte Weißpunkt
sourceL_W = 150; 
destL_W = 1000/pi; 

%Adaptionsleuchtdichte
sourceL_A = sourceL_W * 0.2;
destL_A   = destL_W * 0.2;

%Relative Hintergrundhelligkeit
sourceY_b =  myXYZSource_W(2) * 0.2;
destY_b   = myXYZDest_W(2) * 0.2;

%Relative Umgebungshelligkeit
sourceRelLSurround = 'dim';
destRelLSurround   = 'average';

%Vollständige chromatische Adaption (1=ja, 0=nein)
srcFillDiscount = 0;
destFillDiscount = 1;

%% CIECAM Trafo
% XYZ -> CAM (mit Monitorbedingungen)
monitorCAA = imXYZ2CAM02 (the_XYZMonitor, myXYZSource_W, sourceL_A, ...
             sourceRelLSurround, srcFillDiscount, sourceY_b);
         
% CAM -> XYZ (mit Printbedingungen)
theXYZPrint = imCAM02_2XYZ (monitorCAA, myXYZDest_W, destL_A, ...
               destRelLSurround, destFillDiscount, destY_b);
                        



