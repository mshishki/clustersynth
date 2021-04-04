function theObjectListOut = findObject( theObjectList, theTypeName, theSearchFieldName)
if ~exist( 'theSearchFieldName')
    mySearchFieldName = '';
else
    mySearchFieldName = [ '.', theSearchFieldName];
end

NumObj = size( theObjectList, 2);
Index = [];
myFieldName = cell2mat( fieldnames( theObjectList));

for i=1:NumObj
    myEvalString = [ 'theObjectList.', myFieldName, '(', num2str( i), ')', mySearchFieldName];
    if isType( eval( myEvalString), theTypeName)
        Index = append( Index, i);
    end
end

if ~isempty( Index)
    for i=1:size( Index, 2)
        myEvalString = [ 'theObjectList.', myFieldName, '(', num2str( Index( i)), ')', mySearchFieldName];
        theObjectListOut( i) = eval( myEvalString);
    end
else
    theObjectListOut = [];
end


