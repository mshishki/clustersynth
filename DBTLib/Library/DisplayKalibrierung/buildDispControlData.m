function buildDispControlData( theRGBDisp, theFileName)

%--------------------------
%set up control data
myStringA = 65;

myTab = char( 9);
myNewLine = char( 10);

%--------------------------
%main program

myHeader{ 1} = 'Logo TestChart für Farbmonitore';
myHeader{ 2} = 'BEGIN_DATA_FORMAT';
myHeader{ 3} = 'Sample_ID	RGB_R	RGB_G	RGB_B';
myHeader{ 4} = 'END_DATA_FORMAT';
myHeader{ 5} = 'BEGIN_DATA	';

myTail{ 1} = 'END_DATA		';

myRGB = theRGBDisp;

for i=1:size( myRGB, 1)
	myRows{ i} = [ 'A', num2str( i), myTab, num2str( myRGB( i, 1)), myTab, num2str( myRGB( i, 2)), myTab, num2str( myRGB( i, 3))];
end

myFID = fopen( theFileName, 'w');

for i=1:numel( myHeader)
	fwrite( myFID, myHeader{ i}, 'char');
	fwrite( myFID, myNewLine, 'char');
end
for i=1:numel( myRows)
	fwrite( myFID, myRows{ i}, 'char');
	fwrite( myFID, myNewLine, 'char');
end
for i=1:numel( myTail)
	fwrite( myFID, myTail{ i}, 'char');
	fwrite( myFID, myNewLine, 'char');
end

fclose( myFID);
