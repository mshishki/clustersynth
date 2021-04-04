function [theRawImage, theDemosaickedImage] = getRawImages( theFilename)

myWD = pwd();
[myPath, myName, myExt, myVer] = fileparts( theFilename);
myImageName = [ myName, myExt];
if strcmp( myPath, myWD)==0
    %fremdes Verzeichnis:
    copyfile( 'dcraw.exe', myPath);
    fDel = 1;
else
    fDel = 0;
end

cd( myPath);

theRawImage = openRaw( myImageName);

if nargout == 2
	theDemosaickedImage = getDemosaickedRaw( theRawImage, theFilename);
end

if fDel
    delete( 'dcraw.exe');
end

cd( myWD);
