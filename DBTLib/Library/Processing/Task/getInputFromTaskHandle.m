function theInput = getInputFromTaskHandle( theTaskHandle, theOutputList, theTaskList)
if ~exist( 'theOutputList')
    theInput = getInput( theTaskHandle);
else
    if exist( 'theTaskList')
		myTask = theTaskList( theTaskHandle);
	else
		myTask = getTask( theTaskHandle);
	end
    theInput = myTask.Context.getInput( myTask.Context, theOutputList);
end
