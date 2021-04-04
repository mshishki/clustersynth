function initMatlab( theMainFilePath, theLibFilePath)
clear global;

%warning off;
warning on verbose;

%clear command window
clc;
%close all figures
%close all hidden;

%IPPL anschalten
iptsetpref('UseIPPL', true);

%Globales Arbeitsverzeichnis initialisieren
initWD();

%Working Directory und Pfade setzen
initPaths( theMainFilePath);

if exist( 'theLibFilePath') && ~isempty( theLibFilePath)
	%Pfade mit Unterverzeichnissen setzen:
	addpath( genpath( theLibFilePath));
end
