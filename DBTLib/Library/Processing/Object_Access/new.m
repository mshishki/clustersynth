function theObject = new( theClassName, varargin)

myFuncStr = [ theClassName, '_new(  ', getVarStr( 'varargin', size( varargin{ 1}, 2)), ');'];

theObject = eval( myFuncStr);



