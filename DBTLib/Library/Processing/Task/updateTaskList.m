function updateTaskList( theTaskHandle)
%recalculates and updates figures for tasklist after theTaskHandle
global Application

if ~exist( 'theTaskHandle')
	theTaskHandle = 1;	%der Start Task
end

NumTask = size( Application.TaskList, 2);

%TaskListe ab der Änderung ausführen
[ Application.Output( theTaskHandle:NumTask), Application.TaskList( theTaskHandle:NumTask)] = ...
    executeTaskList( Application.TaskList, Application.Settings, false, theTaskHandle, Application.Output);
