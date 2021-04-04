function setTask( myTask, myTaskHandle)
global Application

Application.TaskList( myTaskHandle) = myTask;
