function theRawImage = getRawImages_Demos( theFilename, theDcrawCommandLine)

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

theRawImage = dcraw_MexModified('-v', '-4', '-o', '0', '-r', '1', '1', '1', '1', '-S', '65535', '-h', theFilename);
%theRawImage = dcraw_MexModified('-v', '-4', '-o', '0', '-r', '1', '1', '1', '1', '-S', '65535', '-h', myImageName);
%myImage = dcraw_Mex('-v', '-D', '-4', NamePlusPath);

%theRawImage = openRaw_Demos( myImageName, theDcrawCommandLine);

if fDel
    delete( 'dcraw.exe');
end

cd( myWD);
