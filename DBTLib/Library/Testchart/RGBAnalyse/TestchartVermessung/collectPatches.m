function [ thePatchCollection, thePatchImage] = collectPatches( theTestchartImage, theRectPatches, theTestchartControl)

myNumX = double( theTestchartControl.NumX);				
myNumY = double( theTestchartControl.NumY);				

[ y, x, c] = size( theTestchartImage);
myMaskImage = logical( zeros( y, x, 'uint16'));

for spalte = 1:uint16(myNumX)
	for zeile = 1:uint16(myNumY)
		% Maskenbild füllen
		myMaskImage( theRectPatches( zeile, spalte, 2):theRectPatches( zeile, spalte, 2)+theRectPatches( zeile, spalte, 4)-1, ...
			theRectPatches( zeile, spalte, 1):theRectPatches( zeile, spalte, 1)+theRectPatches( zeile, spalte, 3)-1) = 1;
		% Patch ausschneiden
		SavePatchInfo.PatchRect = reshape( theRectPatches( zeile, spalte, :), 1, 4);
		myRectImage = imcrop( theTestchartImage, SavePatchInfo.PatchRect);
		SavePatchInfo.Patch = myRectImage;

		%Infos speichern
		if( (zeile == 1) && ( spalte == 1))
			patchArray = SavePatchInfo;
		else
			patchArray( zeile, spalte) = SavePatchInfo;
		end

	end
end

% myMaskDouble = double( myMaskImage( :, :));
% myNotMaskDouble = double( ~myMaskImage( :, :));
% mydoubleTestchartImage = im2double( theTestchartImage);
% mydoubleInvertedTestchartImage = im2double( bitcmp( im2uint16( theTestchartImage)));
% 
% myControlImage = im2uint16( theTestchartImage);
% myControlImage( :, :, 1) = im2uint16( mydoubleTestchartImage( :, :, 1) .* myNotMaskDouble + ...
% 	mydoubleInvertedTestchartImage( :, :, 1) .* myMaskDouble);
% myControlImage( :, :, 2) = im2uint16( mydoubleTestchartImage( :, :, 2) .* myNotMaskDouble + ...
% 	mydoubleInvertedTestchartImage( :, :, 2) .* myMaskDouble);
% myControlImage( :, :, 3) = im2uint16( mydoubleTestchartImage( :, :, 3) .* myNotMaskDouble + ...
% 	mydoubleInvertedTestchartImage( :, :, 3) .* myMaskDouble);

myControlImage = im2uint16( theTestchartImage/theTestchartControl.MaxValue);
if size( myControlImage, 3)==1
	myControlImage( :, :, 2) = myControlImage( :, :, 1);
	myControlImage( :, :, 3) = myControlImage( :, :, 1);
end
myPartImage = myControlImage( :, :, 1);
myPartImage( myMaskImage) = 2^16-1;
myControlImage( :, :, 1) = myPartImage;	%rote Markierung
myPartImage = myControlImage( :, :, 2);
myPartImage( myMaskImage) = 0;
myControlImage( :, :, 2) = myPartImage;	%rote Markierung
myPartImage = myControlImage( :, :, 3);
myPartImage( myMaskImage) = 0;
myControlImage( :, :, 3) = myPartImage;	%rote Markierung

% myControlImage( :, :, 1) = theTestchartImage( :, :, 1) + myMaskImage( :, :);	%rote Markierung
% myControlImage( :, :, 1) = theTestchartImage( :, :, 2) - myMaskImage( :, :);
% myControlImage( :, :, 1) = theTestchartImage( :, :, 3) - myMaskImage( :, :);

thePatchImage = myControlImage;
thePatchCollection = patchArray;

end