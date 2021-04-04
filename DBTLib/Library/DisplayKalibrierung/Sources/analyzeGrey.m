function [theGreyRGB, theGreyRGBLin, theGreyIndices] = analyzeGrey( theRGBData, theRGBLin)

%Spektren
myGreyIndices = find( (theRGBData( :, 1)==theRGBData( :, 2)) & (theRGBData( :, 1)==theRGBData( :, 3)));
[ myGreyRGBSorted, myGreyIndSorted] = sort( theRGBData( myGreyIndices, 1));
myGreyRGBLin  = theRGBLin( myGreyIndices( myGreyIndSorted), :);

%Linearität
figure();
plot( theRGBData( myGreyIndices( myGreyIndSorted), 1), ...
		myGreyRGBLin, '-+k', 'LineWidth', 1.5);
	
if nargout > 0
	theGreyRGB = theRGBData( myGreyIndices( myGreyIndSorted), 1);
end
if nargout > 1
	theGreyRGBLin = myGreyRGBLin;
end
if nargout > 2
	theGreyIndices = myGreyIndices( myGreyIndSorted);
end