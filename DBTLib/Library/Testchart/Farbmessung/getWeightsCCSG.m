function theWeights = getWeightsCCSG()

load GreyPatches;  
GreenPatches = [ 15, 16, 24, 40, 48, 56, 64, 80, 88, ...
					95, 86, 35, 49, 58];
BlueGreenPatches = [ 4, 5, 7, 12, 65];

myNumPatches = 96;

theWeights = ones( myNumPatches, 1, 'double');

theWeights( GreyPatches) = 5;
theWeights( GreenPatches) = 2.5;

