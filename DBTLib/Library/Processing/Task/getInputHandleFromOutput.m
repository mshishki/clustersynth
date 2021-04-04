function theInputHandle = getInputHandleFromOutput( theOutputText)
NumChar = size( theOutputText, 2);

theInputHandle = [];

for i=1:NumChar
    if theOutputText( i)=='['
        for j=i:NumChar
            if theOutputText( j)==']'
                theInputHandle = append( theInputHandle, str2num( theOutputText( i+1:j-1)));
                break;
            end
        end
    end
end

