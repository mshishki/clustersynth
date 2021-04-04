function [ theTotalFileName, theStatus] = getRawFile4Read( theFileExtension, theWindowTitle, thePath)
% usage:  [ theTotalFileName, theStatus] = getRawFile4Read( theFileExtension, theWindowTitle);
% hint:   theTotalFileName is valid if theStatus==1, theWindowTitle is
% optional

if exist( 'theWindowTitle') % && ~isempty( theWindowTitle)
	myMessage = theWindowTitle;
else
	myMessage = 'Select Raw Image:';
end

if exist( 'theFileExtension')
    myFileFilter = theFileExtension;
else
    myFileFilter = '*.*';
end

if exist( 'thePath')
    myPath = thePath;
else
    myPath = '';
end

WorkingDirectory = pwd();
if ~strcmp( myPath, '')
	cd( myPath);
end
[Bilddateiname, Pfad] = uigetfile( myFileFilter, myMessage);
cd( WorkingDirectory);

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
