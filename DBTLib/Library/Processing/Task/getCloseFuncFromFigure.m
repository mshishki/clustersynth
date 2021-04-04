function theCloseFuncHandle = getCloseFuncFromFigure( theFigure)

myUserData = get( theFigure, 'UserData');

if( isfield( myUserData, 'CloseFuncHandle'))
    theCloseFuncHandle = myUserData.CloseFuncHandle;
else
    theCloseFuncHandle = [];
end