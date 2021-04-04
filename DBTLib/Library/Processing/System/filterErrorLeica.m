function filterErrorLeica()

myError = lasterror();
switch( myError.identifier)
    case 'Leica:UserTermination'
        lasterror( 'reset');
    otherwise
        rethrow( myError);
end    
