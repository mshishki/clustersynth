function theTaskOut = installFigureWithMenu( theFigureHandle, theTaskIn, theOutputType, theIndex)
myTaskHandle = getTaskHandleFromTask( theTaskIn);

%verkn�pfen inkl. delete Callback
installTask2Figure( theFigureHandle, myTaskHandle);
theTaskOut = installFigure2Task( theFigureHandle, theTaskIn, theIndex);

%Men�s anpassen
setTask( theTaskOut, myTaskHandle);	%global einrichten f�r den Zugriff der Men�steuerung
adjustMenu( theFigureHandle, theOutputType, getApplicationData( 'Control'));
%             adjustMenu( FigureHandle, Output( i).Type, getApplicationData( 'Control'));


