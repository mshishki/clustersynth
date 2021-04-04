function [ theImageWithoutMean, theMean] = compensateMean( theImage)

%Mittelwert f�r alle Kan�le bestimmen
myMean = mean( mean( theImage));

%Mittelwertfreies Bild erzeugen
for( i=1:size( theImage, 3))
	myImage( :, :, i) = theImage( :, :, i) - myMean( i);
end

%�bergabe
theImageWithoutMean = myImage;

if nargout > 1
	theMean = myMean;
end