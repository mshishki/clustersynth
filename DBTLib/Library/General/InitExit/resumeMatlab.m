function resumeMatlab( theMainFilePath)

global workingDir searchPaths

%Arbeitsverzeichnis wiederherstellen
if( ~isempty( workingDir))
	cd( workingDir);
end

%Pfade löschen ohne Warnung
warning off MATLAB:rmpath:DirNotFound;

if( ~exist( 'theMainFilePath'))
	removePaths( mfilename( 'fullpath'));
else
	removePaths( theMainFilePath);
end

%ursprüngliche Pfade setzen:
if( ~isempty( searchPaths))
	addpath( searchPaths);
end

