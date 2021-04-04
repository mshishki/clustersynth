function dngSaveDirectory = convertRaw2DNG(RAWImageFilePath, run_mode, ...
                                         conversion_options)
%%CONVERTRAW2DNG recieves the path of the raw image, converts
%it to DNG-file and returns its save directory. run_mode can
%be either 'auto' or 'manual'. It is necessary to store 
%images going to be converted in a sourcefolder 'RAW'.
%Oterwise it is necessary to adjust this function.
%
%To run this function there are 2 modes:
%
%'auto': For storing DNGs there has to be a destinationfolder
%in the same directory as the sourcefolder 'RAW' which has
%to be named 'DNG'. (automation mode)
%
%'manual': Still it is necessary to have the sourcefolder
%'RAW', but you can save DNGs maually. (manual mode)
%
%If it is skipped, runOption will be 'auto' by default.
%
%ATTENTION: Adobe DNG Converter has to be installed as
%described in https://wwwimages2.adobe.com/content/dam/Adobe/en/products/photoshop/pdfs/dng_commandline.pdf
%
%NOTE: The options for Adobe DNG Converter can be
%adjusted by the delivered string 'conversion_options'
%(e.g. '-c -l').
%For details about possible options see weblink above as well.
%It is possible to skip this option. In this case 
%conversion_options will be '-u' by default.
%
%Author:    Sebastian Kölle
%
%last modified:     15.09.2014
%last modified by:  S.Kölle
%modified:          PC-compatibility

%% PROGRAMPART1
switch nargin
    case 3
        dngSaveDirectory=functioncall(RAWImageFilePath,run_mode,conversion_options);
    case 2
        if(strcmp(run_mode,'auto')||strcmp(run_mode,'manual'))
            dngSaveDirectory=functioncall(RAWImageFilePath,run_mode,'-u');
        elseif(strcmp(run_mode(1),'-'))
            conversion_options=run_mode;
            dngSaveDirectory=functioncall(RAWImageFilePath,'auto',conversion_options);
        else
            error('myApp:argChk','check second argument');
        end
    case 1
        dngSaveDirectory=functioncall(RAWImageFilePath,'auto','-u');
    otherwise
        error('myApp:argChk','wrong arguments');

end
end

%% PROGRAMPART2
%This is the actual function which converts the raw image and stores the DNG
function dngSaveDirectory = functioncall(RAWImageFilePath,run_mode,conversion_options)

majorPath=RAWImageFilePath;

%Ende bis einschl. letzten Slash löschen
while( majorPath(end)~='/' && majorPath(end)~='\')
    majorPath(end) = [];
end
majorPath(end-4:end)=[];

if ismac
    PathRemove=strrep(RAWImageFilePath,[majorPath '/RAW/'],'');
else
    PathRemove=strrep(RAWImageFilePath,[majorPath '\RAW\'],'');
end
PathRemove(end-3:end)=[];

if(strcmp(run_mode,'auto'))
    if ismac
        saveDir=[majorPath '/DNG/'];
    else
        saveDir=[majorPath '\DNG\'];
    end
    dngImageName=['conv' PathRemove '.dng'];
elseif(strcmp(run_mode,'manual'))
    [dngImageName, saveDir]=uiputfile('.dng','save converted Image',majorPath);
else
    error('myApp:argChk','wrong argument for run_mode');
end

dngSaveDirectory=[saveDir dngImageName];
if exist(dngSaveDirectory,'file');
    return
end

if(ismac)
    dngConverterPath=['/Applications/"Adobe DNG Converter.app"/'...
                      'Contents/MacOS/"Adobe DNG Converter" '];
% elseif(strcmp(computer,'PCWIN64'))
%     dngConverterPath='C:\"Program Files (x86)"\"Adobe DNG Converter.exe';
% elseif(strcmp(computer,'PCWIN'))
%     dngConverterPath='C:\"Program Files"\"Adobe DNG Converter.exe';
else
    error('operatingsystem is not supported for convertRaw2DNG');
end

system([dngConverterPath ' ' conversion_options ' ' ['-d ' saveDir] ...
        ' ' ['-o ' dngImageName] ' ' RAWImageFilePath]);
end
