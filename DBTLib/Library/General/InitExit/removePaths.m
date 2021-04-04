function removePaths( theMFileName)

[ pathstr, name, ext] = fileparts( theMFileName);

%Pfade mit Unterverzeichnissen löschen:
rmpath( genpath( pathstr));
