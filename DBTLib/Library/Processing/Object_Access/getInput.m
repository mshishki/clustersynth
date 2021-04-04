function theInput = getInput( theTaskHandle)
global Application

%theTaskHandle ist unser Index
myTask = getTask( theTaskHandle);
myContext = myTask.Context;
theInput = myContext.getInput( myContext, getOutputList());
