function thePatchImage = formatImage( thePatches)
if( size( thePatches, 1) == 96)
	%Originaldaten CC SG Internal
	myNumY = 8; 
	myNumX = 12;
elseif( size( thePatches, 1) == 140)
	%Originaldaten CC SG
	myNumY = 10; 
	myNumX = 14;
else
	%Unbek. Format -> AR 2:3
	myNumY = floor( 2*sqrt( size( thePatches, 1)/6));
	myNumX = ceil( size( thePatches, 1)/myNumY);
end

thePatchImage = zeros( myNumY, myNumX, 3, 'double');
for i=1:myNumX-1
	thePatchImage( :, i, 1) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myNumY, 1);
	thePatchImage( :, i, 2) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myNumY, 2);
	thePatchImage( :, i, 3) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myNumY, 3);
end
%letzte Spalte:
i=myNumX;
myEnd = floor( (size( thePatches, 1)-1) / myNumY) * myNumY;
myRest = size( thePatches, 1) - myEnd;
thePatchImage( 1:myRest, i, 1) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myRest, 1);
thePatchImage( 1:myRest, i, 2) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myRest, 2);
thePatchImage( 1:myRest, i, 3) = thePatches( (i-1)*myNumY+1:(i-1)*myNumY + myRest, 3);

