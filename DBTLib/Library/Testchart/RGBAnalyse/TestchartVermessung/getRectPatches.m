function theRectPatches = getRectPatches( theMarkers, theTestchartControl)

myUL = double( theMarkers.UpperLeft);
myUR = double( theMarkers.UpperRight);
myBL = double( theMarkers.BottomLeft);
myBR = double( theMarkers.BottomRight);

myNumX = double( theTestchartControl.NumX);				
myNumY = double( theTestchartControl.NumY);				

myUpperGrid = zeros( myNumX, 2);
if myNumX > 1
    for i=1:uint16(myNumX)
        myUpperGrid( i, 1) = myUL( 1) + (myUR( 1) - myUL( 1)) * (double( i-1) / (myNumX-1));
        myUpperGrid( i, 2) = myUL( 2) + (myUR( 2) - myUL( 2)) * (double( i-1) / (myNumX-1));
    end
elseif myNumX ==1
        myUpperGrid( 1, 1) = myUL( 1);
        myUpperGrid( 1, 2) = myUL( 2);
end


myBottomGrid = zeros( myNumX, 2);
if myNumX > 1
    for i=1:uint16(myNumX)
        myBottomGrid( i, 1) = myBL( 1) + (myBR( 1) - myBL( 1)) * (double( i-1) / (myNumX-1));
        myBottomGrid( i, 2) = myBL( 2) + (myBR( 2) - myBL( 2)) * (double( i-1) / (myNumX-1));
    end
elseif myNumX ==1
        myBottomGrid( 1, 1) = myBL( 1);
        myBottomGrid( 1, 2) = myBL( 2);
end

myGrid = zeros( myNumY, myNumX, 2, 'double');
if myNumY > 1
    for spalte = 1:uint16(myNumX)
        for zeile = 1:uint16(myNumY)
            myGrid( zeile, spalte, 1) = myUpperGrid( spalte, 1) + (myBottomGrid( spalte, 1) - myUpperGrid( spalte, 1)) * (double( zeile-1) / (myNumY-1));
            myGrid( zeile, spalte, 2) = myUpperGrid( spalte, 2) + (myBottomGrid( spalte, 2) - myUpperGrid( spalte, 2)) * (double( zeile-1) / (myNumY-1));
        end
    end
elseif myNumY ==1
    for spalte = 1:uint16(myNumX)
        myGrid( 1, spalte, 1) = myUpperGrid( spalte, 1);
        myGrid( 1, spalte, 2) = myUpperGrid( spalte, 2);
    end
end
    

myMinDistanceX = min( [ myUR( 1)- myUL( 1), myBR( 1)- myBL( 1)]);
myMinDistanceY = min( [ myBL( 2)- myUL( 2), myBR( 2)- myUR( 2)]);
if myNumX > 1
    myPatchSizeX = theTestchartControl.RelPatchSizeX * myMinDistanceX / (myNumX-1);
elseif myNumX == 1
    %Größe von Y-Ausdehnung abhängig machen, weil in X-Richtung keine
    %Ausdehnung
    myPatchSizeX = theTestchartControl.RelPatchSizeX * myMinDistanceY / (myNumY-1);
	if( isnan( myPatchSizeX)) %falls nur 1X1 PixGrid
		myPatchSizeX = 1;
	end
end
myPatchSizeX = max( myPatchSizeX, theTestchartControl.MinPatchSizeX);

if myNumY > 1
    myPatchSizeY = theTestchartControl.RelPatchSizeY * myMinDistanceY / (myNumY-1);
elseif myNumY == 1
    %Größe von X-Ausdehnung abhängig machen, weil in Y-Richtung keine
    %Ausdehnung
    myPatchSizeY = theTestchartControl.RelPatchSizeY * myMinDistanceX / (myNumX-1);
	if( isnan( myPatchSizeY)) %falls nur 1X1 PixGrid
		myPatchSizeY = 1;
	end
end
myPatchSizeY = max( myPatchSizeY, theTestchartControl.MinPatchSizeY);

myDeltaX = myPatchSizeX / 2;
myDeltaY = myPatchSizeY / 2;

myRectPatches = zeros( myNumY, myNumX, 4, 'uint16');
myRectPatches( :, :, 1) = uint16( myGrid( :, :, 1) - myDeltaX);
myRectPatches( :, :, 2) = uint16( myGrid( :, :, 2) - myDeltaY);
myRectPatches( :, :, 3) = uint16( myPatchSizeX);
myRectPatches( :, :, 4) = uint16( myPatchSizeY);

theRectPatches = myRectPatches;
