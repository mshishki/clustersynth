function theTask = getTask( theTaskHandle)
global Application

%theTaskHandle ist unser Index
theTask = Application.TaskList( theTaskHandle);
