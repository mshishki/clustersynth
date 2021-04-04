function theBWClear = repairSmearBW( theBWRaw)
myBWIntensity = double( theBWRaw);

% Smearspalten finden:
BadThresh = 0.5;

myColPattern = mean( myBWIntensity, 1);
myColIndex = find( myColPattern > BadThresh);

%BadMask erzeugen:
myBadMask = myBWIntensity > 1000;
for i=1:length( myColIndex)
	myBadMask( :, (myColIndex( i)-1):(myColIndex( i)+1)) = true;
end

theBWClear = roifill( myBWIntensity, myBadMask) > 0.5;
