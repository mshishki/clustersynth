function [ theXYZ, theSpectra, theIllumination] = getXYZfromTestchartIE( theFilename)
%Usage: [ theXYZ, theSpectra, theIllumination] = getXYZfromTestchartIE( theFilename); 
%Optional: theSpectra, theIllumination

mySpectra = getSpectraIE( theFilename);
myIllumination = getD50();
myXYZCurves = getXYZCurves_10nm();

myXYZCurvesXmyIllumination = diag( myIllumination) * myXYZCurves;

myXYZ_Raw = mySpectra * myXYZCurvesXmyIllumination;

%Wei�abgleich
myXYZ = myXYZ_Raw/myXYZ_Raw(45, 2) *100;

%�u�ere Randfarben abschneiden
theXYZ = getInternalPatches( myXYZ);

if( nargout > 1)
    theSpectra = getInternalPatches( mySpectra);
end

if( nargout > 2)
    theIllumination = myIllumination;
end
