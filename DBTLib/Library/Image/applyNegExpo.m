function theDFilmImage = applyNegExpo( theHDRImage, theFilmGradation, theFilmFog)
%CN Film Simulation

%Null für den Log abfangen
myIntensityImage = theHDRImage;
myNullIndizes = find( theHDRImage <= 0);
myIntensityImage( myNullIndizes) = 10^-9;


for i=1:size( myIntensityImage, 3)
	if length( theFilmGradation)==3
		myGradation = theFilmGradation( i);
	else
		myGradation = theFilmGradation;
	end
	%Dichtewandlung
	myDImage( :, :, i) = log10( myIntensityImage( :, :, i)) * myGradation;
end
	
%Minimaldichte ermitteln, mit Tiefpaß
hh = fspecial('disk');
myTPDImage = imfilter( myDImage, hh, 'replicate');
if size( myTPDImage, 3) == 3
	myDMin = min( min( min( myTPDImage)));
else
	myDMin = min( min( myTPDImage));
end

for i=1:size( myDImage, 3)
	if length( theFilmFog)==3
		myFilmFog = theFilmFog( i);
	else
		myFilmFog = theFilmFog;
	end
	
	theDFilmImage( :, :, i) = myDImage( :, :, i) - myDMin + myFilmFog;
end

