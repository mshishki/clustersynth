function installCloseFunc2Figure( theFigure, theCloseFuncHandle)

UserData = get( theFigure, 'UserData');

UserData.CloseFuncHandle = theCloseFuncHandle;

set( theFigure, 'UserData', UserData);
