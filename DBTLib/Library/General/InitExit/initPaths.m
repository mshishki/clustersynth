function initPaths( theMFileName)

global searchPaths

[ pathstr, name, ext] = fileparts( theMFileName);

%urspr�ngliche Pfade sichern:
searchPaths = path();

%Arbeitsverzeichnis setzen
cd( pathstr);

%Pfade mit Unterverzeichnissen setzen:
addpath( genpath( pathstr));

