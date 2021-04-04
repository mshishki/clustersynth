function [ theSpectra, theI1FilenameOut] = getSpectraIE( theI1Filename)
%Usage: theSpectra = getSpectraIE( theI1Filename);
%Keywords for fheI1Filename: 
%		'ColorChecker'
%		'Krinov'
%		'Surfaces'
%		'VrhelDupontPaintChips'
%		'VrhelMunsellChips'
%		'VrhelNaturalObjects'
%		'All'
%		'Vrhel'

mySpectraDir = '';%'ColorData\Spectra';
myKeywordList = { 'ColorChecker', 'Krinov', ...
					'Surfaces', 'VrhelDupontPaintChips', ...
					'VrhelMunsellChips', 'VrhelNaturalObjects', ...
					'All', 'Vrhel'};
				

if( ~exist( 'theI1Filename', 'var') || isempty( theI1Filename))
	theI1Filename = chooseFile4Read( 'Select spectral data file:', '*.txt', mySpectraDir);
end

if ~isempty( theI1Filename)
	%reservierte Bezeichner ausfiltern
	[pathstr, name, ext] = fileparts( theI1Filename);
	if strcmp( ext, '.txt') && ~isempty( cell2mat( strfind( myKeywordList, name)))
		theI1Filename = name;
	end
	%Spektren einlesen
	theSpectra = getSpectra( theI1Filename, 380:10:730);
else
	theSpectra = [];
end

if nargout > 1
	if ~isempty( theI1Filename)
		theI1FilenameOut = theI1Filename;
	else
		theI1FilenameOut = [];
	end
end
	end
