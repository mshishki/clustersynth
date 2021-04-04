function setView( theTaskHandle, theOnOffString)
global Application

%theTaskHandle ist unser Index
Application.TaskList( theTaskHandle).View.FShowFigure = theOnOffString;