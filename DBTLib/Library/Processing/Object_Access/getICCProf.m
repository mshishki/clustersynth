function theICCProfile = getICCProf( theCMList, theType)

theICCProfile = [];

ImageStrStart = strfind( theType, 'Image_');
ImageTypeStart = ImageStrStart + length( 'Image_');
myImageType = theType( ImageTypeStart : end-1);
for i=length( myImageType): -1: 1
    if myImageType( i)=='_'
        %Separator löschen
        myImageType( i) = [];
    end
end

if( isfield( theCMList, myImageType))
    theICCProfile = eval( ['theCMList.', myImageType]);
end
