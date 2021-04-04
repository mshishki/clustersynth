function theImage = dcraw( theCommandLine, thePathPlusFileName)

theImage = dcraw_MexModified2( adjustDCRawCommandLine( theCommandLine), thePathPlusFileName);


function theCommandCellArray = adjustDCRawCommandLine( theDcrawCommandLine)

%in Cell Array zerlegen:
theCommandCellArray = strread( theDcrawCommandLine, '%[^ ]');