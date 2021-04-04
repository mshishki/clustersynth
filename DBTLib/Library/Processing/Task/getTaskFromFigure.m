function theTask = getTaskFromFigure( theFigure)

myTaskList = getApplicationData( 'TaskList');

myTaskHandle = getTaskHandleFromFigure( theFigure);
if( ~isempty( myTaskHandle) && (size( myTaskList, 2) >= myTaskHandle))
    theTask = myTaskList( myTaskHandle);
else
    theTask = [];
end
