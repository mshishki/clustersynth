function theGreyData = getGreyPatches( theInternalData)
%Usage: theGreyData = getGreyPatches( theInternalData);

load GreyPatches;  %alle Felder auﬂer Randfelder

theGreyData = theInternalData( GreyPatches, :);