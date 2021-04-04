function theContext = context_new( theInputHandleArray)

theContext.getInput = @getInput;

if exist( 'theInputHandleArray') && ~isempty( theInputHandleArray)
    PredecessorList = theInputHandleArray( :, 1);
    %evtl. verbessern (passenden Typ bei Input suchen):
    if size( theInputHandleArray, 2) > 1
        theContext.InputHandleArray = theInputHandleArray;
    else
        myInNr = theInputHandleArray; 
        myInNr( :) = 1;
        theContext.InputHandleArray = [ theInputHandleArray, myInNr];
    end
else
    PredecessorList = [];
    theContext.InputHandleArray = [];
end
theContext.Predecessors = PredecessorList;
theContext.Successors = [];



function theInput = getInput( theContext, theOutputList)

Input = [];

for i=1:size( theContext.InputHandleArray, 1)
    if( isempty( Input))
        clear( 'Input');
    end
    Input( i).Input = theOutputList( theContext.InputHandleArray( i, 1)).Output( theContext.InputHandleArray( i, 2)).Output;
%     Input( i) = theOutputList( theContext.InputHandleArray( i, 1)).Output( theContext.InputHandleArray( i, 2));
end

%theInput = Input;
theInput.Input = Input;