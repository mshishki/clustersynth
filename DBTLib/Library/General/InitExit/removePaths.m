function removePaths( theMFileName)

[ pathstr, name, ext] = fileparts( theMFileName);

%Pfade mit Unterverzeichnissen l�schen:
rmpath( genpath( pathstr));
