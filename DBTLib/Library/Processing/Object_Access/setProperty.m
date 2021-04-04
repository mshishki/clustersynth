function theOutObject = setProperty( theObject, thePropertyName, theProperty)

theOutObject = [];

for i=1:size( theObject, 2)

    if( isfield( theObject( i), thePropertyName))
        myOutObject = setfield( theObject( i), thePropertyName, theProperty);
    else
        myOutObject = theObject( i);
        disp( ['Access failed (setProperty): no such field: ', thePropertyName]);
        theObject    
    end
    
    theOutObject = append( theOutObject, myOutObject);
end


