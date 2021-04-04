function theStringRows = readStringRows( theDispControlFileName)

myFID = fopen( theDispControlFileName, 'r');
file = textscan(myFID, '%s', 'delimiter', '\n', ...
                'whitespace', '');

			myData = textread( theDispControlFileName, '%s', 'whitespace', '\b', 'delimiter', '\n');


%----------------------------------
%Header lesen:
myData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
while( isempty( strfind( cell2mat( myData{ i}), 'BEGIN_DATA_FORMAT')))
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
while( isempty( strfind( cell2mat( myData{ i}), 'BEGIN_DATA')))
	i = i+1;
	myData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end
myHeaderEnd_i = i;

%----------------------------------
%Patches einlesen:

myControlData = textscan( myFID, '%s', 1, 'delimiter', '\n');
i = 1;
%Patches auslesen:
while( isempty( strfind( cell2mat( myControlData{ i}), 'END_DATA')))
	i = i+1;
	myControlData( i) = textscan( myFID, '%s', 1, 'delimiter', '\n');
end

%Textdatei auswerten
myFilePatches = textscan( myFID, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f ', myNumPatches);

%Anhang lesen:
%----------------------------------
[ myFileEnd, myNumEnd] = fread( myFID);

fclose( myFID);
