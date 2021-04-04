function theFieldValue = getFieldFromName( theObject, theFieldName)

if ~isempty( theObject)
    [myFieldStructNameList, myFieldName] = separateFields( theFieldName);
    theFieldValue = getField_( theObject, myFieldStructNameList, myFieldName);
else
    theFieldValue = [];
end


function [theFieldStructNameList, theFieldNameOut] = separateFields( theFieldName)
PtString = '.';

if( theFieldName( 1) == PtString)
    theFieldName( 1) = [];
end
if( theFieldName( end) == PtString)
    theFieldName( end) = [];
end

myPointIndices = find( theFieldName(:) == PtString);
myNumFields = length( myPointIndices);

NextNameIndex = 1;
if myNumFields>0
    for i=1:myNumFields
        theFieldStructNameList{ i} = theFieldName( NextNameIndex : myPointIndices( i)-1);
        NextNameIndex = myPointIndices( i)+1;
    end
else
    theFieldStructNameList = [];
end
theFieldNameOut = theFieldName( NextNameIndex : end);



function theValue = getField_( theStruct, theFieldStructNameList, theFieldName)

myNumFields = length( theFieldStructNameList);
myStruct = theStruct;

for i=1:myNumFields
    myName = theFieldStructNameList( i);
    if isfield( myStruct, myName)
        myStruct = myStruct.( myName);
    else
        theValue = [];
        return;
    end
end

if isfield( myStruct, theFieldName)
    theValue =  myStruct.( theFieldName);
else
    theValue = [];
end
