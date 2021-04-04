function [ theSysCallPathPlusFilename, theSysCallPath, theFilename, theExt] = path4syscall( theFilenamePlusPath)

[ myPath, myFilename, myExt] = fileparts( theFilenamePlusPath);

%Überall Anführungszeichen um die Teilpfade setzen
mySCPath = strrep( myPath, '/', '"/"');
mySCPath = strrep( mySCPath, '\', '"/"');

%Letztes Anführungszeichen setzen
mySCPath( end+1) = '"';

%Falls / als erstes Zeichen, ein AnfZeichen zu viel -> löschen
if strcmp( mySCPath( 1:2), '"/')
	mySCPath( 1) = [];
end
%Falls C: / als drittes Zeichen, ein AnfZeichen zu viel -> löschen
if strcmp( mySCPath( 2:4), ':"/')
	mySCPath( 3) = [];
end
if ischar( mySCPath( 1)) && ~strcmp( mySCPath( 1), '/') && ~strcmp( mySCPath( 2), ':')
	%Teilpfad am Anfang -> " einfügen
	mySCPath = [ '"', mySCPath];
end

if isempty( myExt)
	%myFilename ist Teilpfad
	myFilename = [ '"', myFilename, '"'];
end
	
theSysCallPathPlusFilename = [ mySCPath, '/', myFilename, myExt];

if nargout > 1
	theSysCallPath = mySCPath;
end

if nargout > 2
	theFilename = myFilename;
end

if nargout > 3
	theExt = myExt;
end

