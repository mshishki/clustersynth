function theNewMarkers = orderMarkers( theOldMarkers, theTestchartControl)
myX = double( theTestchartControl.Markers.X);
myY = double( theTestchartControl.Markers.Y);
myNum = size( myX, 1);

myDistance = 0;
for i=1:myNum-1
	myDistance = myDistance + abs( myX( 1) - myX( i+1));
end
myDeltaX = myDistance / 2;

myDistance = 0;
for i=1:myNum-1
	myDistance = myDistance + abs( myY( 1) - myY( i+1));
end
myDeltaY = myDistance / 2;

myUpperLeft = [ min( myX), min( myY)];

myUIndices = find( myY <= (myUpperLeft( 2)+myDeltaY/2));
myLIndices = find( myX <= (myUpperLeft( 1)+myDeltaX/2));
myBIndices = find( myY >= (myUpperLeft( 2)+myDeltaY/2));
myRIndices = find( myX >= (myUpperLeft( 1)+myDeltaX/2));

myULIndex = myUIndices( find( ismember( myUIndices, myLIndices)));
myURIndex = myUIndices( find( ismember( myUIndices, myRIndices)));
myBLIndex = myBIndices( find( ismember( myBIndices, myLIndices)));
myBRIndex = myBIndices( find( ismember( myBIndices, myRIndices)));

% Neue Markerstruktur aufsetzen und übergeben:
myMarkers = theOldMarkers;
if( ~isempty( myULIndex))
	%Zuordnung eindeutig
	myMarkers.UpperLeft = [ myX( myULIndex), myY( myULIndex)];
else
	%Zuordnung abhängig von der Ausrichtung der Punkte (Vorzugsricht. x
	%oder y)
	if( myDeltaX > myDeltaY)
		%Vorzugsrichtung x
		myMarkers.UpperLeft = [ myX( myBLIndex), myY( myBLIndex)];
	else
		%Vorzugsrichtung y
		myMarkers.UpperLeft = [ myX( myURIndex), myY( myURIndex)];
	end
end
if( ~isempty( myURIndex))
	%Zuordnung eindeutig
	myMarkers.UpperRight = [ myX( myURIndex), myY( myURIndex)];
else
	%Zuordnung abhängig von der Ausrichtung der Punkte (Vorzugsricht. x
	%oder y)
	if( myDeltaX > myDeltaY)
		%Vorzugsrichtung x
		myMarkers.UpperRight = [ myX( myBRIndex), myY( myBRIndex)];
	else
		%Vorzugsrichtung y
		myMarkers.UpperRight = [ myX( myULIndex), myY( myULIndex)];
	end
end
if( ~isempty( myBLIndex))
	%Zuordnung eindeutig
	myMarkers.BottomLeft = [ myX( myBLIndex), myY( myBLIndex)];
else
	%Zuordnung abhängig von der Ausrichtung der Punkte (Vorzugsricht. x
	%oder y)
	if( myDeltaX > myDeltaY)
		%Vorzugsrichtung x
		myMarkers.BottomLeft = [ myX( myULIndex), myY( myULIndex)];
	else
		%Vorzugsrichtung y
		myMarkers.BottomLeft = [ myX( myBRIndex), myY( myBRIndex)];
	end
end
if( ~isempty( myBRIndex))
	%Zuordnung eindeutig
	myMarkers.BottomRight = [ myX( myBRIndex), myY( myBRIndex)];
else
	%Zuordnung abhängig von der Ausrichtung der Punkte (Vorzugsricht. x
	%oder y)
	if( myDeltaX > myDeltaY)
		%Vorzugsrichtung x
		myMarkers.BottomRight = [ myX( myURIndex), myY( myURIndex)];
	else
		%Vorzugsrichtung y
		myMarkers.BottomRight = [ myX( myBLIndex), myY( myBLIndex)];
	end
end

theNewMarkers = myMarkers;

end % orderMarkers



