function [ theTotalFileName, theStatus] = getRawFile4Read( theFileExtension)
% usage:  [ theTotalFileName, theStatus] = getRawFile4Read( theFileExtension);
% hint:   theTotalFileName is valid if theStatus==1 

if exist( 'theFileExtension')
    myFileFilter = theFileExtension;
else
    myFileFilter = '*.*';
end

WorkingDirectory = pwd();

[Bilddateiname, Pfad] = uigetfile( myFileFilter, 'Choose Raw Image:');
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
