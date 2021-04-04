function theXYZCurves_10nm = getXYZCurves_10nm()
%Usage: theXYZCurves_10nm = getXYZCurves_10nm();

% XYZCurves_5nm = load( 'XYZ2_5nm_380_735.mat');
% theXYZCurves_10nm = XYZCurves_5nm.XYZ2_5nm_380_735( 1:2:end, :);

XYZCurves_5nm = load( 'ciexyz31.txt');

myWaveLen = 380:10:730;
myXYZ = interp1( XYZCurves_5nm( :, 1), XYZCurves_5nm( :, 2:4), myWaveLen);

%Normierung auf 100 für NL E:
theXYZCurves_10nm = myXYZ;
theXYZCurves_10nm( :, 1) = myXYZ( :, 1) ./ sum( myXYZ( :, 1)) * 100;
theXYZCurves_10nm( :, 2) = myXYZ( :, 2) ./ sum( myXYZ( :, 2)) * 100;
theXYZCurves_10nm( :, 3) = myXYZ( :, 3) ./ sum( myXYZ( :, 3)) * 100;

% %in Zeilenvektoren transponieren:
% theXYZCurves_10nm = theXYZCurves_10nm';
