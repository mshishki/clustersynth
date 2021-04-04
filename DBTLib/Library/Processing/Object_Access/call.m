function varargout = call( theObject, theFuncName, varargin)

theParameterList = [];
for i=1:size( varargin, 2)
    myInput( i) = varargin{ i};
    theParameterList = append( theParameterList, ['myInput(', num2str( i), ')']);
end

for i=1:size( theObject, 2)
    if( isfield( theObject( i).FuncPtr, theFuncName))
        varargout = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%         switch nargout
%             case 0
%                 eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']); 
%             case 1
%                 varargout = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%             case 2
%                 [varargout{1}, varargout{2}] = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%             case 3
%                 [varargout{1}, varargout{2}, varargout{3}] = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%             case 4
%                 [varargout{1}, varargout{2}, varargout{3}, varargout{4}] = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%             case 5
%                 [varargout{1}, varargout{2}, varargout{3}, varargout{4}, varargout{5}] = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']);
%             otherwise
%                 disp( ['Too many ouptuts requested: call ', theFuncName]);
%         end
    end
end

    
% if( isfield( theObject( i).FuncPtr, theFuncName))
%     theOutput = eval( [ 'theObject.FuncPtr.', theFuncName, '( ', theParameterList, ')']); 
% end