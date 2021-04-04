function theOutImage = imMatMul( theInImage, theInMatrix)
%Usage: theOutImage = imMatMul( theInImage, theInMatrix);
%Description: computes OutPixVec = theInMatrix * InPixVec;

if( size( theInImage, 2) == size( theInMatrix, 1) && ndims( theInImage) == 2)
	theOutImage = theInImage * theInMatrix';
else	
	[so(1) so(2) thirdD] = size( theInImage);
	theOutImage = reshape( im2double( reshape( theInImage, so(1)*so(2), thirdD)) * theInMatrix', ...
						   so(1), so(2), thirdD);
end
