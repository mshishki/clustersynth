function theInternalData = getInternalPatches( theTotalData)
%Usage: theInternalData = getInternalPatches( theTotalData);

load PatchesforFit;  %alle Felder au�er Randfelder

theInternalData = theTotalData( PatchesforFit, :);