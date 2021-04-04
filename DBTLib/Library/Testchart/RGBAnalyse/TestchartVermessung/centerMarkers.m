function theNewMarkers = centerMarkers( theTestchartImage, theOldMarkers, theTestchartControl)
myX = uint16( theTestchartControl.Markers.X);
myY = uint16( theTestchartControl.Markers.Y);
myNum = size( myX, 1);

myXCenter = myX;
myYCenter = myY;

for i=1:myNum
	[myXCenter( i), myYCenter( i)] = centerMarker( theTestchartImage, [myX( i), myY( i)], theTestchartControl);
end %for

% Neue Markerstruktur aufsetzen und übergeben:
myMarkers = theOldMarkers;
myMarkers.X = myXCenter;
myMarkers.Y = myYCenter;
theNewMarkers = myMarkers;

end % centerMarkers



function 	[theXCenter, theYCenter] = centerMarker( theTestchartImage, theXY, theTestchartControl)
theX = theXY( 1);
theY = theXY( 2);

myThreshold = theTestchartControl.CenterThreshold;

[myYMax, myXMax, Colors] = size( theTestchartImage);

	
	myColor = theTestchartImage( theY, theX, :);
	
	ZeileMinus = theY-1;
	Abbruch = 0;
	while( ZeileMinus>1 && Abbruch==0)
		if colorDifferenceOverThreshold( myColor, theTestchartImage( ZeileMinus, theX, :), myThreshold) == 1
			Abbruch = 1;
		else
			ZeileMinus = ZeileMinus - 1;
		end
	end

	ZeilePlus = theY+1;
	Abbruch = 0;
	while( ZeilePlus<myYMax && Abbruch==0)
		if colorDifferenceOverThreshold( myColor, theTestchartImage( ZeilePlus, theX, :), myThreshold) == 1
			Abbruch = 1;
		else
			ZeilePlus = ZeilePlus + 1;
		end
	end
	
	ZeileCenter = (ZeileMinus + ZeilePlus) / 2;

	SpalteMinus = theX-1;
	Abbruch = 0;
	while( SpalteMinus>1 && Abbruch==0)
		if colorDifferenceOverThreshold( myColor, theTestchartImage( theY, SpalteMinus, :), myThreshold) == 1
			Abbruch = 1;
		else
			SpalteMinus = SpalteMinus - 1;
		end
	end

	SpaltePlus = theX+1;
	Abbruch = 0;
	while( SpaltePlus<myXMax && Abbruch==0)
		if colorDifferenceOverThreshold( myColor, theTestchartImage( theY, SpaltePlus, :), myThreshold) == 1
			Abbruch = 1;
		else
			SpaltePlus = SpaltePlus + 1;
		end
	end

	SpalteCenter = (SpalteMinus + SpaltePlus) / 2;
	
	theXCenter = SpalteCenter;
	theYCenter = ZeileCenter;

end %centerMarker
	
	


function theFlagOverThreshold = colorDifferenceOverThreshold( theColor, theDifColor, theThreshold)
[myY, myXTimesColors] = size( theColor);
myColorDif = theColor - theDifColor;

myColorVector = reshape( double( theColor), myY, myXTimesColors);
myColorDifVector = reshape( double( myColorDif), myY, myXTimesColors);

myRelDif = norm( myColorDifVector) / norm( myColorVector);
theFlagOverThreshold = myRelDif > (1-theThreshold);

end %colorDifferenceOverThreshold