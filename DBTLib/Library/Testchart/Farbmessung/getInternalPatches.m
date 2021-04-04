function theInternalData = getInternalPatches( theTotalData)
%Usage: theInternalData = getInternalPatches( theTotalData);

load PatchesforFit;  %alle Felder auﬂer Randfelder

theInternalData = theTotalData( PatchesforFit, :);