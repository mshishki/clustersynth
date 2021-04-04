function thePapImage_RGBLin = applyPapProcess( theDFilmImage, thePapGradation, theDeltaD)
% Simulation Vergrößerung Filmdichten auf Papier inkl.
% ACR-Gradationskennlinie

%Maximaldichte ermitteln, mit Tiefpaß
hh = fspecial('disk');
myTPDImage = imfilter( theDFilmImage, hh, 'replicate');
if size( myTPDImage, 3) == 3
	myDMax = max( max( max( myTPDImage)));
else
	myDMax = max( max( myTPDImage));
end

for i=1:size( theDFilmImage, 3)
	if length( thePapGradation)==3
		myPapGradation = thePapGradation( i);
	else
		myPapGradation = thePapGradation;
	end
	
	myLogHPapImage( :, :, i) = (-theDFilmImage( :, :, i) + myDMax) * myPapGradation;
end


% %Papierbelichtung inkl. Belichtungskorrektur theDeltaD
% thePapImage_RGBLin = 10.^(-myLogHPapImage+theDeltaD);

%Papierbelichtung inkl. Belichtungskorrektur theDeltaD
myHPapImage = 10.^(-myLogHPapImage+theDeltaD);
%Gradationskurve Papier
thePapImage_RGBLin = applyACR2HDR( myHPapImage, 1, 0);
