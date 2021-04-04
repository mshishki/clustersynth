function theMarkers = setMarkers( theNumMarkers)

if( ~exist( 'theNumMarkers', 'var'))
	theNumMarkers = 4; %default
end

ok=0; 
while ok == 0
	% Marker setzen
	[x,y] = ginput( theNumMarkers);
	
	% Gültigkeit prüfen
	if size( x, 1) == theNumMarkers
		ok = 1;
	else
		display( 'Input of Markers invalid. Mark the centers of the 4 patches at the corners of the Testchart.');
	end
end

myMarkers.Num = theNumMarkers;
myMarkers.X = x;
myMarkers.Y = y;

theMarkers = myMarkers;
