function installTask2Figure( theFigure, theTaskHandle)

UserData = get( theFigure, 'UserData');

UserData.TaskHandle = theTaskHandle;

set( theFigure, 'UserData', UserData);
