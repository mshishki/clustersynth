function theArrayObject = dataArray_new( theArrayData, theArrayTypeName, theArrayFileName)
% data:Array:
% :Type
% :Data.ArrayData
% :Data.Filename
% :FuncPtr.buildFigure( theArrayObject, theTaskHandle)

if ~exist( 'theArrayFileName')
    theArrayFileName = '';
end

theArrayObject = data_new( 'Array');
if( exist( 'theArrayTypeName'))
    if( strcmp( theArrayTypeName, '') == 0)
        theArrayObject.Type = append( theArrayObject.Type, [ '_Array_', theArrayTypeName, '_']);
    else
        theArrayObject.Type = append( theArrayObject.Type, [ '_Array_']);
    end
end
%theArrayObject = setProperty( theArrayObject, 'Type', append( getProperty( theArrayObject, 'Type'), theArrayTypeName));

theArrayObject.Data.ArrayData = theArrayData;
if exist( 'theArrayFileName') 
    theArrayObject.Data.FileName = theArrayFileName;
else
    theArrayObject.Data.FileName = [];
end

theArrayObject.FuncPtr.buildFigure = 0;




