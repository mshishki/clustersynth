function theI1MeasData = getI1MeasurementData( theFileName)
%Usage: theI1MeasData = getI1MeasurementData( theFileName);

persistent  myI1MeasFile

if( exist( 'theFileName')==0 || (isempty( theFileName) && isempty( myI1MeasFile)))
    [myFile, path] = uigetfile('*.txt','Select i1 spectral measurement file:');
	myI1MeasFile = [ path, myFile];
else
    if( not( isempty( theFileName)))
		myI1MeasFile = theFileName;
	end
end

myFID = fopen( myI1MeasFile, 'r');

myData = textscan( myFID, '%s %d', 1);
myI1MeasData.NrOfRows = cell2mat( myData( 1, 2));

myData = textscan( myFID, '%s %d', 1, 'headerlines', 12);

myI1MeasData.NrOfPatches = double( cell2mat( myData( 1, 2)));

myI1MeasData.NrOfCols = myI1MeasData.NrOfPatches / myI1MeasData.NrOfRows;

myI1MeasData.Patches = textscan( myFID, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', myI1MeasData.NrOfPatches, 'headerlines', 2);

fclose( myFID);

theI1MeasData = myI1MeasData;

end %getI1MeasurementData()