function theFilteredVideo = vidFilter( theVideo, theH)

%Anzahl der Dimensionen abfragen:
[ numberOfRows, numberOfColumns, Colors, numberOfFrames] = size( theVideo);

theFilteredVideo = zeros( numberOfRows, numberOfColumns, Colors, numberOfFrames, class( theVideo));

%Bildschleife über Videobilder:
for k = 1 : numberOfFrames
	%Initialisierung zweites Bild:
    theFilteredVideo( :, :, :, k) = imfilter( theVideo( :, :, :, k), theH);
end

