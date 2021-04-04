function theIllumination = getIlluminant( theMessage, theFPlotIlluminant)

if ~exist( 'theMessage', 'var')
	theMessage = 'Select illuminant file (cancel->set Color Temp):';
end

myFilePlusPath = chooseFile4Read( theMessage, ...
								 {'*.mat','MAT-files (*.mat)'; ...
								  '*.xls','Excel Files (*.xls)'; ...
								  '*.txt','Text Files (*.txt)'; ...
								  '*.*',  'All Files (*.*)'}, ...
								  'ColorData');

							  
%initialisieren
theIllumination = [];
if ~isempty( myFilePlusPath)
	
	[ Path, Name, Ext, Versn] = fileparts( myFilePlusPath);
	switch Ext
		case '.xls'
			%Excel File	
			[ Typ, Sheets, Mode] = xlsfinfo( myFilePlusPath);
			myIllum = xlsread( myFilePlusPath, Sheets{ 1});
			if( numel( myIllum( :, 1)) == 36)
				theIllumination = myIllum( :, 1);
			end
		case '.mat'
			%Mat File
			myInput = load( myFilePlusPath);
			myNames = fieldnames( myInput);
			for( i=1:length( myNames))
				myArray = myInput.(cell2mat( myNames( 1)));
				if( numel( myArray) == 36)
					myIllum = myArray;
					theIllumination = myIllum( :);
					break;
				end
			end
		case '.txt'
			%Textfile
			myIllum = importdata( myFilePlusPath); %load( myFilePlusPath); dlmread( myFilePlusPath, ', ');
			if( numel( myIllum) == 36)
				theIllumination = myIllum( :);
			end
		otherwise
			theIllumination = [];
	end
else
	theColorTempStr = inputdlg( 'Set current color temperature (°K):', 'Input Color Temperature', 1, {'5000'});
	theIllumination = getT( str2num( theColorTempStr{ 1}));
end

if ~exist( 'theFPlotIlluminant', 'var') || theFPlotIlluminant
	%Nur bei übergebener 0 ausgeschaltet
	if( ~isempty( theIllumination))
		plot1DSpectral( theIllumination, 'Illuminant spectrum');
	end
end
