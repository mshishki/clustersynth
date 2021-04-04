function theCFAPattern = getCFAPattern( theCFAMatrix)
%[0, 1; 1, 2] -> [ 0 1 1 2]
myCFAMatrixTransp = theCFAMatrix';
theCFAOrder = myCFAMatrixTransp(:)';

%[ 0 1 1 2] -> 'rggb'
for i=1:numel( theCFAOrder)
	theCFAPattern( i) = num2rgb( theCFAOrder( i));
end

function theRGBLetter = num2rgb( theNumber123)
	switch theNumber123
		case 0
			theRGBLetter = 'r';
		case 1
			theRGBLetter = 'g';
		case 2
			theRGBLetter = 'b';
		otherwise
			theRGBLetter = '';
	end
	
		
