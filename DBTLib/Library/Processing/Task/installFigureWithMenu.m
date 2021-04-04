function theTaskOut = installFigureWithMenu( theFigureHandle, theTaskIn, theOutputType, theIndex)
myTaskHandle = getTaskHandleFromTask( theTaskIn);

%verknüpfen inkl. delete Callback
installTask2Figure( theFigureHandle, myTaskHandle);
theTaskOut = installFigure2Task( theFigureHandle, theTaskIn, theIndex);

%Menüs anpassen
setTask( theTaskOut, myTaskHandle);	%global einrichten für den Zugriff der Menüsteuerung
adjustMenu( theFigureHandle, theOutputType, getApplicationData( 'Control'));
%             adjustMenu( FigureHandle, Output( i).Type, getApplicationData( 'Control'));


