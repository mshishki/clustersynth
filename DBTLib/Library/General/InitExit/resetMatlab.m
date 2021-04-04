function resetMatlab( theMainFilePath)

if( exist( 'theMainFilePath'))
	resumeMatlab( theMainFilePath);
else
	resumeMatlab();
end

%clear command window
%clc;
%figure and vars
%close all hidden;
clear variables;
clear global;

