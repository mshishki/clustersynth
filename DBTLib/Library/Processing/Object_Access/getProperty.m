function thePropertyList = getProperty( theObject, thePropertyName)

thePropertyList = {};

for i=1:size( theObject, 2)

    if( isfield( theObject( i), thePropertyName))
        myProperty = getfield( theObject, thePropertyName);
    else
        myProperty = [];
    end
    
    thePropertyList = append( thePropertyList, myProperty);
end

