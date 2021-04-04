function theMatImage = imMatMul_Single( theImage, theFloatMatrix)

mySingleMatrix = single( theFloatMatrix);
myDoubleMatrix = double( theFloatMatrix);

if( size( theImage, 2) == size( theFloatMatrix, 1) && ndims( theImage) == 2)
	theMatImage = theImage * theFloatMatrix';
else
	[so(1) so(2) thirdD] = size( theImage);
	theImage = reshape( theImage, so(1)*so(2), thirdD);

	if isa( theImage, 'uint8')
		theMatImage = uint8( single( theImage) * mySingleMatrix');
	elseif isa( theImage, 'uint16')
		theMatImage = uint16( single( theImage) * mySingleMatrix');
	elseif isa( theImage, 'single')
		theMatImage = theImage * mySingleMatrix';
	elseif isa( theImage, 'double')
		theMatImage = theImage * myDoubleMatrix';
	end

	theMatImage = reshape( theMatImage, so(1), so(2), thirdD);
end

