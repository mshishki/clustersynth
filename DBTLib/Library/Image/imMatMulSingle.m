function theMatImageSingle = imMatMulSingle( theImage, theMatrix)

myMatrix = single( theMatrix);
if( size( theImage, 2) == size( theMatrix, 1) && ndims( theImage) == 2)
	theMatImageSingle = theImage * theMatrix';
else	
	[so(1) so(2) thirdD] = size( theImage);
	theImage = reshape( theImage, so(1)*so(2), thirdD);
	theMatImageSingle = im2single( theImage) * myMatrix';
	theMatImageSingle = reshape( theMatImageSingle, so(1), so(2), thirdD);
end
