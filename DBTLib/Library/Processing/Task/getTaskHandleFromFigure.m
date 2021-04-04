function theTaskHandle = getTaskHandleFromFigure( theFigure)

myUserData = get( theFigure, 'UserData');

if( isfield( myUserData, 'TaskHandle'))
    theTaskHandle = myUserData.TaskHandle;
else
    theTaskHandle = [];
end