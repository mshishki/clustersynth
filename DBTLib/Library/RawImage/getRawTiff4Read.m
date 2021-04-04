function [ theTotalFileName, theStatus] = getRawTiff4Read()

WorkingDirectory = pwd();

[Bilddateiname, Pfad] = uigetfile( '*.tif', 'Choose Raw Image:');
if( exist( 'Bilddateiname')==0 || ischar( Bilddateiname)==0)
    myStatus = 0;
else
    myStatus = 1;
end
if strcmp( WorkingDirectory, Pfad)==1
    UsePfad = ''; 
else
    UsePfad = Pfad;
end
theTotalFileName = [ UsePfad, Bilddateiname];

if nargout > 1
    theStatus = myStatus;
end
