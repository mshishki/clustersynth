function thePatchesResult = analyzePatches( thePatchCollection)

[myNumY, myNumX] = size( thePatchCollection);

for spalte = 1:uint16(myNumX)
	for zeile = 1:uint16(myNumY)
		% Bisherige Ergebnisse behalten
		SavePatchInfo = thePatchCollection( zeile, spalte);
		% Bildausschnitt holen
		myRectImage = SavePatchInfo.Patch;
		
		% Mittelwerte und Standardabweichungen berechnen
		if size( myRectImage, 3)==1
			%SW
			SavePatchInfo.Mean = [ mean2( myRectImage( :, :))];
			SavePatchInfo.Std = [ std2( myRectImage( :, :))];
		else
			%Color
			SavePatchInfo.Mean = [ mean2( myRectImage( :, :, 1)), mean2( myRectImage( :, :, 2)), mean2( myRectImage( :, :, 3))];
			SavePatchInfo.Std = [ std2( myRectImage( :, :, 1)), std2( myRectImage( :, :, 2)), std2( myRectImage( :, :, 3))];
		end
		
		%Ergebnisse sammeln
		if( (zeile == 1) && ( spalte == 1))
			patchArray = SavePatchInfo;
		else
			patchArray( zeile, spalte) = SavePatchInfo;
		end

	end
end

thePatchesResult = patchArray;
