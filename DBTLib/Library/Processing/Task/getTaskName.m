function theTaskName = getTaskName( theAlgo_theTaskHandle)

if isstruct( theAlgo_theTaskHandle)
    %theAlgo übergeben
    myAlgo = theAlgo_theTaskHandle;
    myTaskHandle = getProperty( theAlgo_theTaskHandle, 'TaskHandle');
else
    myTaskHandle = theAlgo_theTaskHandle;
    myTask = getTask( myTaskHandle);
    myAlgo = myTask.Algo;
end

myTaskList = getApplicationData( 'TaskList');

theTaskName = ['T[', num2str( myTaskHandle), ']', getProperty( myAlgo, 'Name')];

