function savePatchResults( thePatchesResult, theControl, thePatchImage, theTestchartImageName)

myWD = pwd();

TestchartResults.ImageFileName = char( theTestchartImageName);
TestchartResults.Control = theControl;
TestchartResults.Patches = thePatchesResult;

[pathstr,name,ext] = fileparts( theTestchartImageName);
mySaveName = [ char( name), '.mat'];
myPatchImageName = [ char( name), '_Patches.tif'];

if( strcmp( pathstr, '') == 0)
	cd( pathstr);
end

save( mySaveName, 'TestchartResults');
imwrite( thePatchImage, myPatchImageName);

cd( myWD);