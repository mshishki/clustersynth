function theGreyData = getGreyPatches( theInternalData)
%Usage: theGreyData = getGreyPatches( theInternalData);

load GreyPatches;  %alle Felder au�er Randfelder

theGreyData = theInternalData( GreyPatches, :);