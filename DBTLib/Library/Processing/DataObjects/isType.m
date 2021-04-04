function theIsIt = isType( theDataObject_TypeString, theTypeName)

if exist( 'theDataObject_TypeString')
    if isfield( theDataObject_TypeString, 'Type')
        %DataObject �bergeben
        k = strfind( theDataObject_TypeString.Type, theTypeName);
    elseif ischar( theDataObject_TypeString)
        %Type String �bergeben
        k = strfind( theDataObject_TypeString, theTypeName);
    else
        k = [];
    end
else
    k = [];
end

theIsIt = ~isempty( k);
