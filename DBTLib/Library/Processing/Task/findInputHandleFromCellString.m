function theOutputIndex = findInputHandleFromCellString( theOutputListCellString, theInputHandle)

theOutputIndex = [];

myNumStrings = size( theOutputListCellString, 2);
for i=1:myNumStrings
    if getInputHandleFromOutput( cell2mat( theOutputListCellString( i))) == theInputHandle
        theOutputIndex = i;
        break;
    end
end
